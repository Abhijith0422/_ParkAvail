<<<<<<< HEAD
// ignore_for_file: must_be_immutable, deprecated_member_use

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../application/bloc/parkdata_bloc.dart';
import 'infopage.dart';

class HomepageInfo extends StatelessWidget {
  final String districtname;
  HomepageInfo({super.key, required this.districtname});
  String prevdistrictname = "";
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> refreshNotifier = ValueNotifier<int>(0);
    if (prevdistrictname == districtname) {
      log(prevdistrictname);
      log(districtname);
      prevdistrictname != "Trivandrum"
          ? WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ParkdataBloc>(
              context,
            ).add(ParkdataEvent.getdata(districtname));
            Timer.periodic(const Duration(seconds: 10), (timer) {
              refreshNotifier.value++;
            });
          })
          : WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ParkdataBloc>(
              context,
            ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
            Timer.periodic(const Duration(seconds: 10), (timer) {
              refreshNotifier.value++;
            });
          });

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parking Slots',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                districtname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                districtname != "Trivandrum"
                    ? BlocProvider.of<ParkdataBloc>(
                      context,
                    ).add(ParkdataEvent.getdata(districtname))
                    : BlocProvider.of<ParkdataBloc>(
                      context,
                    ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
              },
            ),
          ],
        ),
        body: ValueListenableBuilder<int>(
          valueListenable: refreshNotifier,
          builder: (context, value, child) {
            // Trigger data refresh without showing the loading indicator

            return BlocBuilder<ParkdataBloc, ParkdataState>(
              builder: (context, state) {
                log(state.toString());
                if (state.isLoading && state.parkdata.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CupertinoActivityIndicator(color: Colors.white),
                        const SizedBox(height: 16),
                        Text(
                          'Loading parking data...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.parkdata.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 48,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No internet connection",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      districtname != "Trivandrum"
                          ? BlocProvider.of<ParkdataBloc>(
                            context,
                          ).add(ParkdataEvent.getdata(districtname))
                          : BlocProvider.of<ParkdataBloc>(
                            context,
                          ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.parkdata.length,
                      itemBuilder: (context, index) {
                        final parkData = state.parkdata[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: const Color.fromARGB(255, 32, 41, 56),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => InfoAboutPark(
                                          districName: districtname,
                                          index: index,
                                        ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color:
                                            parkData.availability!
                                                ? Colors.green.withOpacity(0.2)
                                                : Colors.red.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.local_parking_rounded,
                                        color:
                                            parkData.availability!
                                                ? Colors.green
                                                : Colors.red,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${parkData.name}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            parkData.availability!
                                                ? "Available"
                                                : "Not Available",
                                            style: TextStyle(
                                              color:
                                                  parkData.availability!
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
=======
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
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
                  );
                }
              },
            );
<<<<<<< HEAD
          },
        ),
        backgroundColor: const Color.fromARGB(255, 23, 31, 43),
      );
    } else {
      districtname != "Trivandrum"
          ? WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ParkdataBloc>(
              context,
            ).add(ParkdataEvent.getdata(districtname));
            Timer.periodic(const Duration(seconds: 10), (timer) {
              refreshNotifier.value++;
            });
          })
          : WidgetsBinding.instance.addPostFrameCallback((_) {
            BlocProvider.of<ParkdataBloc>(
              context,
            ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
            Timer.periodic(const Duration(seconds: 10), (timer) {
              refreshNotifier.value++;
            });
          });

      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parking Slots',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                districtname,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                districtname != "Trivandrum"
                    ? BlocProvider.of<ParkdataBloc>(
                      context,
                    ).add(ParkdataEvent.getdata(districtname))
                    : BlocProvider.of<ParkdataBloc>(
                      context,
                    ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
              },
            ),
          ],
        ),
        body: ValueListenableBuilder<int>(
          valueListenable: refreshNotifier,
          builder: (context, value, child) {
            prevdistrictname = districtname;
            // Trigger data refresh without showing the loading indicator

            return BlocBuilder<ParkdataBloc, ParkdataState>(
              builder: (context, state) {
                if (state.isLoading && state.parkdata.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CupertinoActivityIndicator(color: Colors.white),
                        const SizedBox(height: 16),
                        Text(
                          'Loading parking data...',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state.parkdata.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.wifi_off_rounded,
                          size: 48,
                          color: Colors.white.withOpacity(0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No internet connection",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () async {
                      districtname != "Trivandrum"
                          ? BlocProvider.of<ParkdataBloc>(
                            context,
                          ).add(ParkdataEvent.getdata(districtname))
                          : BlocProvider.of<ParkdataBloc>(
                            context,
                          ).add(ParkdataEvent.getdata("Thiruvananthapuram"));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.parkdata.length,
                      itemBuilder: (context, index) {
                        final parkData = state.parkdata[index];
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: const Color.fromARGB(255, 32, 41, 56),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => InfoAboutPark(
                                          districName: districtname,
                                          index: index,
                                        ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color:
                                            parkData.availability!
                                                ? Colors.green.withOpacity(0.2)
                                                : Colors.red.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.local_parking_rounded,
                                        color:
                                            parkData.availability!
                                                ? Colors.green
                                                : Colors.red,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${parkData.name}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            parkData.availability!
                                                ? "Available"
                                                : "Not Available",
                                            style: TextStyle(
                                              color:
                                                  parkData.availability!
                                                      ? Colors.green
                                                      : Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 23, 31, 43),
      );
    }
=======
          }),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
  }
}
