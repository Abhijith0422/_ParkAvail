import 'package:book_my_park/presentation/profile/bookings.dart';
import 'package:book_my_park/presentation/profile/personalinfo.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: const Color.fromARGB(255, 23, 31, 43),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey),
                    color: Colors.transparent),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=BpR0FVaEa5F24GIw7K8nMWiiGmbb8qmhfkpXcp1dhQg="),
                                  fit: BoxFit.contain)))),
                  const Text(
                    "Profile Name",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text("My Details",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily:
                                  GoogleFonts.portLligatSans().fontFamily,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BookingsPage()));
                          },
                          icon: const Icon(Icons.menu_outlined),
                          label: const Text("Bookings",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 0),
                    child: Align(
                      alignment: FractionalOffset.topLeft,
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonalInfoPage()));
                          },
                          icon: const Icon(Icons.menu_outlined),
                          label: const Text("Personal Info",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ]))));
  }
}
