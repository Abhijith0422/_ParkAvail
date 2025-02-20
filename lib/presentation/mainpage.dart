<<<<<<< HEAD
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'booking/bottomnav.dart';
=======
import 'package:book_my_park/presentation/booking/bottomnav.dart';
import 'package:flutter/material.dart';

>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'booking/homescreen.dart';
import 'profile/profilepage.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
<<<<<<< HEAD
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
=======
  final List list = [const HomeScreen(), const Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (context, int index, _) {
          return list[index];
        },
      ),
      bottomNavigationBar: const BottomNavBar(),
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    );
  }
}
