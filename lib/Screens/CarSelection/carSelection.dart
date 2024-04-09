import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'carModelSelection.dart';

class CarSelection extends StatefulWidget {
  @override
  _CarSelectionState createState() => _CarSelectionState();
}

class _CarSelectionState extends State<CarSelection> {
  late TextEditingController searchController;
  late List<String> vehicleData;
  String _selectedManufacturer = "";

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    vehicleData = [];
    fetchManufacturers();
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87, // Set background color to black
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 210, 209, 209), // Set background color to grey
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                    searchManufacturer(query);
                    setState(() {
                      _selectedManufacturer = "";
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Manufacturer',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: vehicleData.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white, // Set separator color to white
                ),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      vehicleData[index],
                      style: TextStyle(
                          color: Colors.white), // Set text color to white
                    ),
                    onTap: () {
                      setState(() {
                        _selectedManufacturer = vehicleData[index];
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarModelSelection(
                            selectedManufacturer: _selectedManufacturer,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
