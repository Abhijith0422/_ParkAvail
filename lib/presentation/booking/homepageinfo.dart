import 'dart:async';

import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/presentation/booking/infopage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageInfo extends StatelessWidget {
  final String districtname;
  const HomepageInfo({super.key, required this.districtname});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> refreshNotifier = ValueNotifier<int>(0);
    Timer.periodic(const Duration(seconds: 10), (timer) {
      refreshNotifier.value++;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ParkdataBloc>(context)
          .add(ParkdataEvent.getdata(districtname));
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Parking Slots in $districtname',
            style: const TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
            )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ValueListenableBuilder<int>(
          valueListenable: refreshNotifier,
          builder: (context, value, child) {
            // Trigger data refresh without showing the loading indicator
            BlocProvider.of<ParkdataBloc>(context)
                .add(ParkdataEvent.getdata(districtname));
            return BlocBuilder<ParkdataBloc, ParkdataState>(
              builder: (context, state) {
                if (state.isLoading && state.parkdata.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.parkdata.isEmpty) {
                  return const Center(
                      child: Text(
                    "Check your internet connection",
                    style: TextStyle(color: Colors.white),
                  ));
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      BlocProvider.of<ParkdataBloc>(context)
                          .add(ParkdataEvent.getdata(districtname));
                    },
                    child: ListView.builder(
                        itemCount: state.parkdata.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${state.parkdata[index].name}',
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(state.parkdata[index].availability!
                                ? "Available"
                                : "Not Available"),
                            trailing: Icon(Icons.local_parking_rounded,
                                color: state.parkdata[index].availability!
                                    ? Colors.green
                                    : Colors.red),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoAboutPark(
                                            districName: districtname,
                                            index: index,
                                          )));
                            },
                          );
                        }),
                  );
                }
              },
            );
          }),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }
}
