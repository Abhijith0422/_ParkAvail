import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bookedSlots = [
      'Slot 1: 10:00 AM - 11:00 AM',
      'Slot 2: 11:00 AM - 12:00 PM',
      'Slot 3: 12:00 PM - 01:00 PM',
      'Slot 4: 01:00 PM - 02:00 PM',
      'Slot 5: 02:00 PM - 03:00 PM',
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booked Slots',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
            )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: bookedSlots.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(bookedSlots[index],
                style: const TextStyle(color: Colors.white)),
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }
}
