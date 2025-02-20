<<<<<<< HEAD
// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../application/bloc/parkdata_bloc.dart';
import '../../custom/silvergrid.dart';
import 'onbooking.dart';
import '../../domain/booking_model.dart';
=======
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/custom/silvergrid.dart';
import 'package:book_my_park/presentation/booking/onbooking.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

class BookingView extends StatelessWidget {
  final int index;
  final String districtname;
<<<<<<< HEAD
  BookingView({super.key, required this.index, required this.districtname});
  final ValueNotifier<Set<int>> selectedIconIndices = ValueNotifier<Set<int>>(
    {},
  );
  final ValueNotifier<DateTime> selectedTime = ValueNotifier<DateTime>(
    DateTime.now(),
  );

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedTime.value),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.green,
              onPrimary: Colors.white,
              surface: Color(0xFF2A3441),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      selectedTime.value = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
    }
  }

  Future<void> saveBooking(
    BuildContext context,
    int slotNumber,
    String district,
    String parkingName,
    String location,
  ) async {
    bool isContextValid = context.mounted;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (isContextValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please login to book a slot')),
          );
        }
        return;
      }

      // Create a unique booking ID that includes user ID
      final String bookingId =
          '${user.uid}_${DateTime.now().millisecondsSinceEpoch}';

      final booking = BookingModel(
        id: bookingId,
        slotNumber: slotNumber,
        district: district,
        timeSlot: DateFormat('hh:mm a').format(selectedTime.value),
        isActive: true,
        userId: user.uid,
        bookingDate: DateTime.now(),
        parkingName: parkingName,
        location: location,
        startTime: selectedTime.value,
      );

      // Check if slot is already booked
      final existingBooking =
          await FirebaseFirestore.instance
              .collection('bookings')
              .where('district', isEqualTo: district)
              .where('slotNumber', isEqualTo: slotNumber)
              .where('isActive', isEqualTo: true)
              .where(
                'startTime',
                isEqualTo: selectedTime.value.toIso8601String(),
              )
              .get();

      if (existingBooking.docs.isNotEmpty) {
        throw Exception('This slot is already booked for the selected time');
      }

      final bookingRef = FirebaseFirestore.instance
          .collection('bookings')
          .doc(booking.id);
      final districtRef = FirebaseFirestore.instance
          .collection('districts')
          .doc(district);

      final districtDoc = await districtRef.get();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        if (!districtDoc.exists) {
          transaction.set(districtRef, {
            'name': district,
            'totalSlots': 20,
            'availableSlots': 19,
          });
        } else {
          final currentSlots = districtDoc.data()?['availableSlots'] ?? 0;
          if (currentSlots > 0) {
            transaction.update(districtRef, {
              'availableSlots': currentSlots - 1,
            });
          } else {
            throw Exception('No slots available');
          }
        }

        transaction.set(bookingRef, booking.toJson());
      });

      if (isContextValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Slot Booked successfully!')),
        );

        await Future.delayed(const Duration(milliseconds: 500));

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      BookingPage(districtName: district, index: index),
            ),
          );
        }
      }
    } catch (e) {
      if (isContextValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error booking slot: ${e.toString()}')),
        );
      }
    }
  }
=======
  BookingView({
    super.key,
    required this.index,
    required this.districtname,
  });
  final ValueNotifier<Set<int>> selectedIconIndices =
      ValueNotifier<Set<int>>({});
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Select Parking Slot",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ParkdataBloc, ParkdataState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 32, 41, 56),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Available Slots",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${state.parkdata[index].aslot}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                        _buildLegend(),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 24),
                    ValueListenableBuilder<DateTime>(
                      valueListenable: selectedTime,
                      builder: (context, time, child) {
                        return ListTile(
                          leading: const Icon(
                            Icons.access_time,
                            color: Colors.white70,
                          ),
                          title: Text(
                            'Selected Time: ${DateFormat('hh:mm a').format(time)}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: TextButton(
                            onPressed: () => _selectTime(context),
                            child: const Text(
                              'Change',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Tap on an available slot to select",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount:
                              int.tryParse("${state.parkdata[index].tslot}") ??
                              0,
                          gridDelegate: CustomSliverGridDelegate(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            additionalSpacing: 50,
                            columnsBeforeSpacing: 2,
                          ),
                          itemBuilder: (context, newindex) {
                            String label = generateLabel(newindex);
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: ValueListenableBuilder<Set<int>>(
                                valueListenable: selectedIconIndices,
                                builder: (context, selectedIndices, child) {
                                  final isSelected = selectedIndices.contains(
                                    newindex,
                                  );
                                  return GestureDetector(
                                    onTap: () {
                                      if (!selectedIndices.contains(newindex)) {
                                        selectedIconIndices.value = {
                                          ...selectedIconIndices.value,
                                          newindex,
                                        };
                                        saveBooking(
                                          context,
                                          newindex,
                                          districtname,
                                          state.parkdata[index].name!,
                                          state.parkdata[index].location!,
                                        );
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            isSelected
                                                ? Colors.red.withOpacity(0.2)
                                                : const Color.fromARGB(
                                                  255,
                                                  32,
                                                  41,
                                                  56,
                                                ),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              isSelected
                                                  ? Colors.red
                                                  : Colors.green,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.1,
                                            ),
                                            blurRadius: 4,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          label,
                                          style: TextStyle(
                                            color:
                                                isSelected
                                                    ? Colors.red
                                                    : Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _buildLegendItem(Colors.green, "Available"),
        const SizedBox(width: 16),
        _buildLegendItem(Colors.red, "Booked"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  String generateLabel(int index) {
    int row = index % 4; // Assuming 4 columns
    int column = index ~/ 4;
    String rowLabel = String.fromCharCode(
      65 + row,
    ); // Convert row number to letter (A, B, C, ...)
    String columnLabel =
        (column + 1).toString(); // Convert column number to 1-based index
    return '$rowLabel$columnLabel';
  }
=======
        title: const Text("Parking Slots",
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ParkdataBloc, ParkdataState>(builder: (context, state) {
        return Column(
          children: [
            Text("Available Slots: ${state.parkdata[index].aslot}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            Expanded(
              child: GridView.builder(
                itemCount: int.tryParse("${state.parkdata[index].tslot}") ?? 0,
                gridDelegate: CustomSliverGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  additionalSpacing: 50,
                  columnsBeforeSpacing: 2,
                ),
                itemBuilder: (context, newindex) {
                  return Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 9, 221, 94),
                      ),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: ValueListenableBuilder<Set<int>>(
                        valueListenable: selectedIconIndices,
                        builder: (context, selectedIndices, child) {
                          return IconButton(
                            onPressed: () {
                              if (!selectedIndices.contains(newindex)) {
                                selectedIconIndices.value = {
                                  ...selectedIconIndices.value,
                                  newindex
                                };
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingPage(
                                      districtName: districtname,
                                      index: index,
                                    ),
                                  ),
                                );
                              }
                            },
                            icon: Icon(
                              Icons.local_parking_rounded,
                              size: 15,
                              color: selectedIndices.contains(newindex)
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
}
