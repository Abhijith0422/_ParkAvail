import 'dart:developer';
import 'dart:io'; // Add this line
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Add this line
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Add this line
// Add this import
import 'dart:async'; // Add this import

import '../../api/supabase_service.dart';
import '../booking/bottomnav.dart';
import '../signup/login.dart';
import '../signup/signin/auth_services.dart';

String name = '';
String ph = '';
String email = '';
String licenseNumber = '';
String profileImageUrl = ''; // Add this line

class PersonalInfoPage extends StatefulWidget {
  // Change to StatefulWidget
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final ImagePicker _picker = ImagePicker();
  final SupabaseService _supabaseService = SupabaseService(); // Add this line
  DateTime? _urlExpiryTime;
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _initializeData();
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

  Future<void> _initializeData() async {
    await fetchuserdata();
    if (profileImageUrl.isNotEmpty) {
      final freshUrl = await _supabaseService.getSignedUrl(profileImageUrl);
      if (freshUrl != null) {
        setState(() {
          profileImageUrl = freshUrl;
          _urlExpiryTime = DateTime.now().add(const Duration(hours: 1));
        });
      }
    }
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
        _urlExpiryTime = DateTime.now().add(const Duration(hours: 1));
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Info',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171F2B), Color(0xFF1F2937)],
          ),
        ),
        child: FutureBuilder(
          future: fetchuserdata(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Hero(
                        tag: 'profile_picture',
                        child: Stack(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
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
                      const SizedBox(height: 24),
                      Card(
                        elevation: 8,
                        color: const Color(0xFF2A3441),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildInfoRowEnhanced(
                                'Name',
                                name,
                                Icons.person_outline,
                                context,
                              ),
                              const Divider(color: Colors.white24),
                              _buildInfoRowEnhanced(
                                'Email',
                                email,
                                Icons.email_outlined,
                                context,
                              ),
                              const Divider(color: Colors.white24),
                              _buildInfoRowEnhanced(
                                'Phone',
                                ph,
                                Icons.phone_outlined,
                                context,
                              ),
                              const Divider(color: Colors.white24),
                              _buildInfoRowEnhanced(
                                'License Number',
                                licenseNumber,
                                Icons.credit_card_outlined,
                                context,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.primary,
                              Theme.of(context).colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                            indexNotifier.value = 0;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Sign Out",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoRowEnhanced(
    String label,
    String value,
    IconData icon,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white70),
            onPressed: () => _showEditDialog(context, label, value),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, String label, String value) {
    final controller = TextEditingController(text: value);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A3441),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Edit $label',
            style: const TextStyle(color: Colors.white),
          ),
          content: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              labelText: label,
              labelStyle: const TextStyle(color: Colors.white70),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white38),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () async {
                try {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String fieldName;
                    switch (label) {
                      case 'Name':
                        fieldName = 'name';
                        name = controller.text;
                        break;
                      case 'Phone':
                        fieldName = 'phone';
                        ph = controller.text;
                        break;
                      case 'License Number':
                        fieldName = 'licenseNumber';
                        licenseNumber = controller.text;
                        break;
                      default:
                        return;
                    }

                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      },
                    );

                    // Update Firestore
                    await FirebaseFirestore.instance
                        .collection('userdata')
                        .doc(user.uid)
                        .update({fieldName: controller.text});

                    // Close loading indicator
                    Navigator.pop(context);
                    // Close edit dialog
                    Navigator.pop(context);
                    // Refresh the page
                    setState(() {});

                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$label updated successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  // Close loading indicator if it's showing
                  Navigator.pop(context);
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error updating $label: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }
}

fetchuserdata() async {
  try {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      email = firebaseUser.email!;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('userdata')
          .doc(firebaseUser.uid)
          .get()
          .timeout(const Duration(seconds: 10));

      if (docSnapshot.exists) {
        name = docSnapshot.data()?['name'] ?? '';
        ph = docSnapshot.data()?['phone'] ?? '';
        licenseNumber = docSnapshot.data()?['licenseNumber'] ?? '';
        profileImageUrl =
            docSnapshot.data()?['profileImageUrl'] ?? ''; // Add this line
      } else {
        log('No user data found');
        name = '';
        ph = '';
        licenseNumber = '';
        profileImageUrl = ''; // Add this line
      }
    }
  } catch (e) {
    log('Error fetching user data: $e');
    rethrow; // This will be caught by the FutureBuilder
  }
}
