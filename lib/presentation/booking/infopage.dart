<<<<<<< HEAD
// ignore_for_file: deprecated_member_use
=======
import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/presentation/booking/booking.dart';
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

<<<<<<< HEAD
import '../../application/bloc/parkdata_bloc.dart';
import 'booking.dart';
=======
import 'package:google_fonts/google_fonts.dart';

>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'gmap.dart';

final ScrollController _scrollController = ScrollController();

class InfoAboutPark extends StatelessWidget {
  final int index;
  final String districName;
<<<<<<< HEAD
  const InfoAboutPark({
    super.key,
    required this.index,
    required this.districName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          'Parking Details',
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
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
      body: BlocBuilder<ParkdataBloc, ParkdataState>(
        builder: (context, state) {
          return SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'parkImage${state.parkdata[index].name}',
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image:
                            state.parkdata[index].image != ""
                                ? NetworkImage("${state.parkdata[index].image}")
                                : const AssetImage("assets/noimage.jpg")
                                    as ImageProvider,
                        fit: BoxFit.cover,
                        opacity: 0.7,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.parkdata[index].name}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.white70,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      "${state.parkdata[index].location}",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(context, state.parkdata[index]),
                      const SizedBox(height: 20),
                      _buildActionButtons(context, state.parkdata[index]),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, dynamic parkData) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 41, 56),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow("Total Slots", "${parkData.tslot}", Icons.car_rental),
          const Divider(height: 1, color: Colors.white12),
          _buildInfoRow(
            "Available Slots",
            "${parkData.aslot}",
            Icons.check_circle_outline,
          ),
          const Divider(height: 1, color: Colors.white12),
          _buildInfoRow(
            "Amount",
            "₹${parkData.price}",
            Icons.currency_rupee,
            isPrice: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    bool isPrice = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.white70, size: 20),
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              color: isPrice ? Colors.green : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, dynamic parkData) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              launchGoogleMaps(
                parkData.latitude as double,
                parkData.longitude as double,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4285F4),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.directions, color: Colors.white),
            label: const Text(
              'Get Directions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed:
                parkData.availability!
                    ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => BookingView(
                                index: index,
                                districtname: districName,
                              ),
                        ),
                      );
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  parkData.availability! ? Colors.green : Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: Icon(
              parkData.availability! ? Icons.check_circle : Icons.cancel,
              color: Colors.white,
            ),
            label: Text(
              parkData.availability! ? 'Book Now' : 'Not Available',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
=======
  const InfoAboutPark(
      {super.key, required this.index, required this.districName});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ParkdataBloc>(context)
          .add(ParkdataEvent.getdata(districName));
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'ParkAvail',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: BlocBuilder<ParkdataBloc, ParkdataState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                    color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("${state.parkdata[index].name}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                          )),
                    ),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: state.parkdata[index].image != ""
                                  ? Image.network(
                                      "${state.parkdata[index].image}",
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                        }
                                      },
                                    )
                                  : Image.asset(
                                      "assets/noimage.jpg",
                                      fit: BoxFit.fill,
                                    )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 260, 20, 10),
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 120,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFF4285F4),
                              ),
                              child: TextButton.icon(
                                  onPressed: () {
                                    launchGoogleMaps(
                                        state.parkdata[index].latitude
                                            as double,
                                        state.parkdata[index].longitude
                                            as double);
                                  },
                                  icon: Icon(
                                    Icons.location_on,
                                    color: Colors.green[900],
                                  ),
                                  label: const Center(
                                    child: Text(
                                      "Directions",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )),
                            )),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("${state.parkdata[index].location}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 10, 10),
                                    child: Text(
                                      "Total Slots : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 10),
                                    child:
                                        Text("${state.parkdata[index].tslot}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            )),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 10, 10),
                                    child: Text(
                                      "Available Slots : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 10),
                                    child:
                                        Text("${state.parkdata[index].aslot}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            )),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 10, 10),
                                    child: Text(
                                      "Amount : ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 10),
                                    child:
                                        Text("${state.parkdata[index].price}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            )),
                                  ),
                                ),
                              ]),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 30, 8, 30),
                      child: Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: state.parkdata[index].availability!
                                ? Colors.green
                                : Colors.red),
                        child: TextButton(
                            onPressed: () {
                              if (state.parkdata[index].availability!) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BookingView(
                                            index: index,
                                            districtname: districName)));
                              }
                            },
                            child: Text(
                              state.parkdata[index].availability!
                                  ? "Book Now"
                                  : "Not Available",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    );
  }
}
