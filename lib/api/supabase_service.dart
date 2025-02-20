import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../domain/api/apiendpoints.dart'; // Add this import

class SupabaseService {
  final supabase = Supabase.instance.client;
  late final SupabaseClient adminClient;

  SupabaseService() {
    // Initialize admin client with service role key
    adminClient = SupabaseClient(zupaurl, serviceRoleKey);
    _initializeBucket();
  }

  Future<void> _initializeBucket() async {
    try {
      // Try to get bucket info to check if it exists
      await adminClient.storage.getBucket('userimages');
    } catch (e) {
      if (e.toString().contains('Bucket not found')) {
        // Create bucket if it doesn't exist
        await adminClient.storage.createBucket(
          'userimages',
          const BucketOptions(public: true),
        );
      }
    }
  }

  Future<void> syncUserWithFirebase() async {
    try {
      final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
      if (firebaseUser == null) return;

      // Use admin client for profile operations
      await adminClient.from('profiles').upsert({
        'id': firebaseUser.uid,
        'email': firebaseUser.email,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error syncing user: $e');
      rethrow;
    }
  }

  Future<String> _getSignedUrl(String path, {int expiresIn = 3600}) async {
    try {
      final signedUrl = await adminClient.storage
          .from('userimages')
          .createSignedUrl(path, expiresIn);
      return signedUrl;
    } catch (e) {
      print('Signed URL generation error: $e');
      throw Exception('Failed to generate secure image URL');
    }
  }

  Future<String> uploadProfileImage(File imageFile, String userId) async {
    try {
      final fileExtension = imageFile.path.split('.').last;
      final fileName = '$userId/profile.$fileExtension';

      // Ensure bucket exists before upload
      await _initializeBucket();

      await adminClient.storage
          .from('userimages')
          .upload(
            fileName,
            imageFile,
            fileOptions: const FileOptions(upsert: true),
          );

      final signedUrl = await _getSignedUrl(fileName);

      await adminClient
          .from('profiles')
          .update({'avatar_url': signedUrl, 'avatar_path': fileName})
          .eq('id', userId);

      return signedUrl;
    } catch (e) {
      print('Upload error details: $e');
      if (e.toString().contains('AccessDenied')) {
        throw Exception('Access denied. Please check storage permissions.');
      }
      rethrow;
    }
  }

  Future<String> refreshImageUrl(String userId) async {
    try {
      final user =
          await adminClient
              .from('profiles')
              .select('avatar_path')
              .eq('id', userId)
              .single();

      final avatarPath = user['avatar_path'] as String?;
      if (avatarPath == null) throw Exception('No avatar path found');

      final signedUrl = await _getSignedUrl(avatarPath);

      await adminClient
          .from('profiles')
          .update({'avatar_url': signedUrl})
          .eq('id', userId);

      return signedUrl;
    } catch (e) {
      throw Exception('Failed to refresh URL: ${e.toString()}');
    }
  }

  Future<String> getPublicUrl(String path) async {
    return _getSignedUrl(path);
  }

  Future<String?> getSignedUrl(String originalUrl) async {
    try {
      // Extract the path from the original URL
      final uri = Uri.parse(originalUrl);
      final path = uri.pathSegments.join('/');

      // Get fresh signed URL with 1 hour expiry
      final signedUrl = await supabase.storage
          .from('profile-images')
          .createSignedUrl(path, 3600);

      return signedUrl;
    } catch (e) {
      print('Error getting signed URL: $e');
      // If there's an error with the signed URL, return the original URL as fallback
      return originalUrl;
    }
  }
}
