import 'package:book_my_park/application/bloc/parkdata_bloc.dart';
import 'package:book_my_park/presentation/booking/booking.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';

import 'gmap.dart';

final ScrollController _scrollController = ScrollController();

class InfoAboutPark extends StatelessWidget {
  final int index;
  final String districName;
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
    );
  }
}
