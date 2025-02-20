import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'mainpage.dart';
import 'signup/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MainPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
