<<<<<<< HEAD
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
=======
import 'package:flutter/material.dart';

>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
import 'homepageinfo.dart';

class PlaceGrid extends StatelessWidget {
  const PlaceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
<<<<<<< HEAD
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
=======
      'assets/Trivandrum.png',
      'assets/kollam.png',
      'assets/Alaapuzha.png',
      'assets/Pathanamthitta.png',
      'assets/Kottayam.png',
      'assets/idukki.png',
      'assets/Ernakulam.png',
      'assets/trissur.png',
      'assets/palakad.png',
      'assets/malapuram.png',
      'assets/Kozhikode.png',
      'assets/wayanad.png',
      'assets/kannur.png',
      'assets/kasargod.png',
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
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
<<<<<<< HEAD
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
=======
      'Kasaragod'
    ];

    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (context, index) {
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomepageInfo(
                                      districtname: districtnames[index],
                                    )));
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                imagePaths[index],
                                width: 120,
                                height: 120,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        districtnames[index],
                        style:
                            const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ));
      },
      itemCount: 14,
>>>>>>> 036b57e0e3b6b646c3710d1fd6ed73cbaec7d65c
    );
  }
}
