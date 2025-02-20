// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';

import 'dart:io';

import '../../api/supabase_service.dart';
import '../mainpage.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  bool isLoading = false;

  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  final SupabaseService _supabaseService = SupabaseService();

  InputDecoration _getInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.tealAccent),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white38),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.tealAccent),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024, // Limit image size
        maxHeight: 1024,
        imageQuality: 85, // Compress image
      );

      if (pickedFile != null) {
        final File file = File(pickedFile.path);
        // Check file size (limit to 2MB)
        final int fileSize = await file.length();
        if (fileSize > 2 * 1024 * 1024) {
          _showErrorSnackBar('Image size should be less than 2MB');
          return;
        }
        setState(() {
          _imageFile = file;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Failed to pick image: ${e.toString()}');
    }
  }

  Future<String?> _uploadImageToSupabase() async {
    try {
      if (_imageFile == null) return null;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('User not authenticated');
        return null;
      }

      // Upload to Supabase and get URL
      final downloadUrl = await _supabaseService.uploadProfileImage(
        _imageFile!,
        user.uid,
      );

      return downloadUrl;
    } catch (e) {
      _showErrorSnackBar('Failed to upload image: ${e.toString()}');
      return null;
    }
  }

  Future<void> _saveUserInfo() async {
    // Validation
    if (nameController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        licenseController.text.trim().isEmpty) {
      _showErrorSnackBar('Please fill all fields');
      return;
    }

    if (!RegExp(r'^\d{10}$').hasMatch(phoneController.text.trim())) {
      _showErrorSnackBar('Please enter a valid 10-digit phone number');
      return;
    }

    if (licenseController.text.trim().length < 8) {
      _showErrorSnackBar('Please enter a valid license number');
      return;
    }

    setState(() => isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        _showErrorSnackBar('User not authenticated');
        return;
      }

      // Upload image if selected
      String? imageUrl;
      if (_imageFile != null) {
        imageUrl = await _uploadImageToSupabase();
      }

      // Prepare user data
      final userData = {
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'licenseNumber': licenseController.text.trim().toUpperCase(),
        if (imageUrl != null) 'profileImageUrl': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // If it's a new user, add createdAt
      final userDoc =
          await FirebaseFirestore.instance
              .collection('userdata')
              .doc(user.uid)
              .get();

      if (!userDoc.exists) {
        userData['createdAt'] = FieldValue.serverTimestamp();
      }

      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('userdata')
          .doc(user.uid)
          .set(userData, SetOptions(merge: true));

      _showSuccessSnackBar('Profile saved successfully');

      // Navigate to MainPage
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (e) {
      _showErrorSnackBar('Failed to save profile: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Complete Your Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1a237e), Color(0xFF0d47a1), Color(0xFF01579b)],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Profile Image Section
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.tealAccent.withOpacity(0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.tealAccent,
                              width: 2,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              shape: BoxShape.circle,
                              image:
                                  _imageFile != null
                                      ? DecorationImage(
                                        image: FileImage(_imageFile!),
                                        fit: BoxFit.cover,
                                      )
                                      : null,
                            ),
                            child:
                                _imageFile == null
                                    ? const Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.white70,
                                    )
                                    : null,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.tealAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Form Fields
                    TextField(
                      controller: nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _getInputDecoration(
                        'Full Name',
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: licenseController,
                      style: const TextStyle(color: Colors.white),
                      decoration: _getInputDecoration(
                        'License Number',
                        Icons.card_membership,
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: phoneController,
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.phone,
                      decoration: _getInputDecoration(
                        'Phone Number',
                        Icons.phone_outlined,
                      ),
                      maxLength: 10,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _saveUserInfo,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.tealAccent,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                        ),
                        child:
                            isLoading
                                ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Save Profile',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    licenseController.dispose();
    super.dispose();
  }
}
