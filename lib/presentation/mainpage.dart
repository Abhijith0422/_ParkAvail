// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'booking/bottomnav.dart';
import 'booking/homescreen.dart';
import 'profile/profilepage.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final List list = [HomeScreen(), const Profile()];

  Future<bool> _onWillPop(BuildContext context) async {
    final shouldExit = await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Exit App?'),
            content: const Text('Are you sure you want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
    );

    if (shouldExit ?? false) {
      SystemNavigator.pop();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: indexNotifier,
          builder: (context, int index, _) {
            return list[index];
          },
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
