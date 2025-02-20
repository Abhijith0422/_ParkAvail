// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'homepageinfo.dart';

class PlaceGrid extends StatelessWidget {
  const PlaceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/Trivandrum.jpg',
      'assets/kollam.jpg',
      'assets/Alaapuzha.jpg',
      'assets/Pathanamthitta.jpg',
      'assets/Kottayam.jpg',
      'assets/idukki.jpg',
      'assets/Ernakulam.jpg',
      'assets/trissur.jpg',
      'assets/palakad.jpg',
      'assets/malapuram.jpg',
      'assets/Kozhikode.jpg',
      'assets/wayanad.jpg',
      'assets/kannur.jpg',
      'assets/kasargod.jpg',
    ];

    final List<String> districtnames = [
      'Trivandrum',
      'Kollam',
      'Alappuzha',
      'Pathanamthitta',
      'Kottayam',
      'Idukki',
      'Ernakulam',
      'Thrissur',
      'Palakkad',
      'Malappuram',
      'Kozhikode',
      'Wayanad',
      'Kannur',
      'Kasaragod',
    ];

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          childAspectRatio: 1.0,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: InkWell(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              HomepageInfo(districtname: districtnames[index]),
                    ),
                  ),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(imagePaths[index], fit: BoxFit.fill),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          districtnames[index],
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, childCount: districtnames.length),
      ),
    );
  }
}
