// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
// Add this import

import '../../api/supabase_service.dart';
import 'bookings.dart';

import 'personalinfo.dart';

class Profile extends StatefulWidget {
  // Change to StatefulWidget
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String profileImageUrl = '';
  String userName = ''; // Add this line
  final ImagePicker _picker = ImagePicker();
  final SupabaseService _supabaseService = SupabaseService(); // Add this line
  DateTime? _urlExpiryTime;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _loadProfileImage();
    _loadUserName(); // Add this line
    // Set up periodic URL refresh
    _refreshTimer = Timer.periodic(const Duration(minutes: 45), (_) {
      _refreshImageUrl();
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _refreshImageUrl() async {
    if (profileImageUrl.isEmpty) return;

    // Check if URL needs refresh (less than 5 minutes until expiry)
    if (_urlExpiryTime != null &&
        _urlExpiryTime!.difference(DateTime.now()).inMinutes <= 5) {
      final freshUrl = await _supabaseService.getSignedUrl(profileImageUrl);
      if (freshUrl != null) {
        setState(() {
          profileImageUrl = freshUrl;
          _urlExpiryTime = DateTime.now().add(const Duration(hours: 1));
        });
      }
    }
  }

  Future<void> _loadProfileImage() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('userdata')
              .doc(user.uid)
              .get();
      if (doc.exists && doc.data()?['profileImageUrl'] != null) {
        // Get fresh signed URL
        final storedUrl = doc.data()?['profileImageUrl'];
        final freshUrl = await _supabaseService.getSignedUrl(storedUrl);
        setState(() {
          profileImageUrl = freshUrl ?? storedUrl;
          _urlExpiryTime = DateTime.now().add(const Duration(hours: 1));
        });
      }
    }
  }

  Future<void> _loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc =
          await FirebaseFirestore.instance
              .collection('userdata')
              .doc(user.uid)
              .get();
      if (doc.exists && doc.data()?['name'] != null) {
        final fullName = doc.data()?['name'] as String;
        final firstName = fullName.split(' ')[0]; // Get only the first name
        setState(() {
          userName = firstName;
        });
      }
    }
  }

  Future<void> _uploadImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Upload to Supabase and get URL
      final downloadUrl = await _supabaseService.uploadProfileImage(
        File(image.path),
        user.uid,
      );

      // Update Firestore with the new URL
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user.uid)
          .update({'profileImageUrl': downloadUrl});

      setState(() {
        profileImageUrl = downloadUrl;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171F2B), Color(0xFF1F2937)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Hero(
                tag: 'profile_picture',
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                        image: DecorationImage(
                          image:
                              profileImageUrl.isNotEmpty
                                  ? NetworkImage(profileImageUrl)
                                  : const NetworkImage(
                                    "https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=BpR0FVaEa5F24GIw7K8nMWiiGmbb8qmhfkpXcp1dhQg=",
                                  ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: _uploadImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName.isNotEmpty ? userName : "Profile Name",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A3441),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "My Details",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    _buildProfileOption(
                      context: context,
                      icon: Icons.calendar_today_outlined,
                      title: "Bookings",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BookingsPage(),
                            ),
                          ),
                    ),
                    const Divider(height: 1, color: Colors.white24),
                    _buildProfileOption(
                      context: context,
                      icon: Icons.person_outline,
                      title: "Personal Info",
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PersonalInfoPage(),
                            ),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.white70, size: 24),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
