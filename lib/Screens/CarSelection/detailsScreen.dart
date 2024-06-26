import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:effecient/Auth/HomePage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:effecient/Screens/PortSelection/EvPortSelectionScreen.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final String selectedManufacturer;
  final String selectedModel;

  DetailsScreen({
    required this.selectedManufacturer,
    required this.selectedModel,
  });

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late String additionalDetails = '';

  @override
  void initState() {
    super.initState();
    // Fetch details if needed
    // fetchDetails();
  }

  // Future<void> fetchDetails() async {
  //   try {
  //     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //         .collection('versions')
  //         .where('manufacturer', isEqualTo: widget.selectedManufacturer)
  //         .where('model', isEqualTo: widget.selectedModel)
  //         .where('version', isEqualTo: widget.selectedVersion)
  //         .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       setState(() {
  //         additionalDetails = querySnapshot.docs.first['details'] as String;
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching details: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selected EV',
          style: TextStyle(color: Colors.blueAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Brand: ${widget.selectedManufacturer}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Model: ${widget.selectedModel}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Back',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: () {
                    CoolAlert.show(
                        context: context,
                        type: CoolAlertType.confirm,
                        text: "Are you sure with selection",
                        confirmBtnText: "Yes",
                        cancelBtnText: "No",
                        showCancelBtn: true,
                        onCancelBtnTap: () {
                          Navigator.of(context).pop();
                        },
                        onConfirmBtnTap: () {
                          Provider.of<chDataProvider>(context, listen: false)
                              .defaultBrand = widget.selectedManufacturer;
                          Provider.of<chDataProvider>(context, listen: false)
                              .defaultModel = widget.selectedModel;
                          print(Provider.of<chDataProvider>(context,
                                  listen: false)
                              .defaultBrand);
                          print(Provider.of<chDataProvider>(context,
                                  listen: false)
                              .defaultModel);
                          String Email = Provider.of<chDataProvider>(context,
                                  listen: false)
                              .userEmail!;

                          // Setting the choosen data to user's DB in Firebase

                          addUserDefaults(Email, widget.selectedManufacturer,
                              widget.selectedModel);
                          // Navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text('Select',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                )
              ],
            ),
            // ElevatedButton(
            //   onPressed: () {},
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.blue,
            //     minimumSize: Size(
            //       double.infinity, // Full width
            //       48.0,
            //     ),
            //   ),
            //   child: Text('Select',
            //       style: TextStyle(fontSize: 16, color: Colors.white)),
            // ),

            // Button for Going Back
          ],
        ),
      ),
    );
  }

  void successAlertAndNavigate() async {
    // Show alert with a delay
    // Future.delayed(Duration(seconds: 3), () {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Alert message!'),
    //       duration: Duration(seconds: 2), // Alert duration
    //     ),
    //   );
    // });
    // CoolAlert.show(
    //     context: context,
    //     type: CoolAlertType.confirm,
    //     text: "Please choose Vehicle Model",
    //     confirmBtnText: "OK",
    //     showCancelBtn: false,
    //     onConfirmBtnTap: () {
    //       Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => const HomePage(),
    //         ),
    //       );
    //     });
  }

  // Function to add defaultBrand and defaultModel to a user document
  Future<void> addUserDefaults(
      String userEmail, String defaultBrand, String defaultModel) async {
    // Get a reference to the Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Query for the document with the specified email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: userEmail).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document per email, get the reference to that document
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the document with defaultBrand and defaultModel fields
        await userDocRef.update({
          'defaultBrand': defaultBrand,
          'defaultModel': defaultModel,
        });

        print('User defaults added successfully.');
      } else {
        print('No user found with the specified email.');
      }
    } catch (e) {
      print('Error adding user defaults: $e');
    }
  }
}
