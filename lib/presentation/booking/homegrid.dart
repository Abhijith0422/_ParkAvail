import 'package:flutter/material.dart';

import 'homepageinfo.dart';

class PlaceGrid extends StatelessWidget {
  const PlaceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
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
    );
  }
}
