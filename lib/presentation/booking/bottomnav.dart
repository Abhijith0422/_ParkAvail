// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

ValueNotifier<int> indexNotifier = ValueNotifier<int>(0);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (context, int newindex, _) {
          return BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 23, 31, 43),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              currentIndex: newindex,
              onTap: (index) {
                indexNotifier.value = index;
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]);
        });
  }
}
