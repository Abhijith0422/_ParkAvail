import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/custom/silvergrid.dart';
import 'package:book_my_park/presentation/booking/onbooking.dart';

class BookingView extends StatelessWidget {
  final int index;
  final String districtname;
  BookingView({
    super.key,
    required this.index,
    required this.districtname,
  });
  final ValueNotifier<Set<int>> selectedIconIndices =
      ValueNotifier<Set<int>>({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
}
