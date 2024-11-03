import 'package:book_my_park/presentation/signup/login.dart';
import 'package:book_my_park/presentation/signup/signin/auth_services.dart';
import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Personal Info', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://media.istockphoto.com/id/1327592506/vector/default-avatar-photo-placeholder-icon-grey-profile-picture-business-man.jpg?s=612x612&w=0&k=20&c=BpR0FVaEa5F24GIw7K8nMWiiGmbb8qmhfkpXcp1dhQg="),
                        fit: BoxFit.contain))),
            _buildInfoRow('Name ', 'John Doe', context: context),
            _buildInfoRow('Email ', 'john.doe@example.com', context: context),
            _buildInfoRow('Phone ', '+1234567890', context: context),
            _buildInfoRow('Address ', '123 Main St, City, Country',
                context: context),
            _buildInfoRow('License No ', "202400000610", context: context),
            Center(
              child: Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: TextButton.icon(
                    onPressed: () {
                      signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    label: const Text("SignOut",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    icon: const Icon(
                      color: Colors.white,
                      Icons.logout_outlined,
                    )),
              ),
            )
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 23, 31, 43),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {required BuildContext context}) {
    TextEditingController controller = TextEditingController(text: value);
    controller.text = value;
    return Column(
      children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$label:',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Row(
                  children: [
                    Text(controller.text,
                        style: const TextStyle(color: Colors.white)),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit $label'),
                              content: TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: label,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(controller.text);
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
