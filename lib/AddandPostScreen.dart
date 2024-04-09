import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddandPostScreen extends StatefulWidget {
  const AddandPostScreen({Key? key}) : super(key: key);

  @override
  _AddandPostScreenState createState() => _AddandPostScreenState();
}

class _AddandPostScreenState extends State<AddandPostScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables to store values from text fields
  String avail = '';
  String ChrgSp = '';
  String dist = '';
  String Lat = '';
  String Long = '';
  String Slots = '';
  String cost = '';
  String title = '';

  // Reference to the Firebase Realtime Database
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('Locations');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add and Post Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField('Availibility', (value) {
              avail = value;
            }),
            buildTextField('Charging Speed', (value) {
              ChrgSp = value;
            }),
            buildTextField('Distance', (value) {
              dist = value;
            }),
            buildTextField('Latitude', (value) {
              Lat = value;
            }),
            buildTextField('Long', (value) {
              Long = value;
            }),
            buildTextField('Slots', (value) {
              Slots = value;
            }),
            buildTextField('cost', (value) {
              cost = value;
            }),
            buildTextField('title', (value) {
              title = value;
            }),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save data to Firebase
                    _saveDataToFirebase();
                    avail = '';
                    ChrgSp = '';
                    dist = '';
                    Lat = '';
                    Long = '';
                    Slots = '';
                    cost = '';
                    title = '';

                    // Display a snackbar with the entered data
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Data submitted to Firebase')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String hintText, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: onChanged,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Please enter some text';
      //   }
      //   return null;
      // },
    );
  }

  void _saveDataToFirebase() {
    // Create a map containing user data
    Map<String, dynamic> userData = {
      'Availability': avail,
      'Charging Speed (KW)': ChrgSp,
      'Distance': dist,
      'Latitude': Lat,
      'Longitude': Long,
      'No of Slots available': Slots,
      'cost': cost,
      'title': title,
    };

    // Save data to Firebase under the unique key
    _databaseReference.child(title).set(userData);
  }
}
