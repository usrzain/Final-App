import 'package:effecient/Providers/chData.dart';
import 'package:effecient/navBar/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'carModelSelection.dart';

class CarSelection extends StatefulWidget {
  @override
  _CarSelectionState createState() => _CarSelectionState();
}

class _CarSelectionState extends State<CarSelection> {
  late TextEditingController searchController;
  List<String> vehicleData = ['BMW', 'Honda', 'Tesla'];
  String _selectedManufacturer = "";

// Map car brands to their corresponding logo asset paths
  final Map<String, String> brandLogoPaths = {
    'BMW': 'assets/bmw.png',
    'Honda': 'assets/honda.png',
    'Tesla': 'assets/tesla__.png',
  };

  @override
  void initState() {
    // fetchManufacturers();
    super.initState();
    searchController = TextEditingController();
  }

  void fetchManufacturers() async {
    try {
      QuerySnapshot manufacturersSnapshot =
          await FirebaseFirestore.instance.collection('manufacturer').get();
      List<String> tempManufacturers = manufacturersSnapshot.docs
          .map((doc) => doc['brand'].toString())
          .toList();

      setState(() {
        vehicleData = tempManufacturers;
      });
    } catch (e) {
      print('Error fetching manufacturers: $e');
    }
  }

  void searchManufacturer(String query) async {
    try {
      QuerySnapshot manufacturersSnapshot = await FirebaseFirestore.instance
          .collection('manufacturer')
          .where('brand', isGreaterThanOrEqualTo: query)
          .get();

      List<String> tempManufacturers = manufacturersSnapshot.docs
          .map((doc) => doc['brand'].toString())
          .toList();

      setState(() {
        vehicleData = tempManufacturers;
      });
    } catch (e) {
      print('Error searching manufacturers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Manufacturers',
          style: TextStyle(color: Colors.blueAccent),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: vehicleData.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  indent: 12,
                  endIndent: 12,
                  thickness: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final brand = vehicleData[index];
                  final logoPath = brandLogoPaths[brand]; // Get logo path

                  return ListTile(
                    title: Row(
                      children: [
                        // Display logo if available
                        if (logoPath != null)
                          Image.asset(
                            logoPath,
                            width: 30,
                            height: 30,
                            //color: white,
                            fit: BoxFit.contain, // Adjust size as needed
                          ),
                        SizedBox(
                            width: 10), // Add spacing between logo and text
                        Text(
                          brand,
                          style: TextStyle(color: Colors.white),
                        ),
                        Spacer(),
                        if (_selectedManufacturer == vehicleData[index])
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    selected: _selectedManufacturer == vehicleData[index],
                    selectedTileColor: Colors.blueAccent,
                    onTap: () {
                      setState(() {
                        _selectedManufacturer = vehicleData[index];
                      });
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Previous',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarModelSelection(
                          selectedManufacturer: _selectedManufacturer,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
