// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc/parkdata_bloc.dart';
import 'booking.dart';
import 'gmap.dart';

final ScrollController _scrollController = ScrollController();

class InfoAboutPark extends StatelessWidget {
  final int index;
  final String districName;
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
    );
  }
}
