import 'package:effecient/Providers/chData.dart';
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(
                255, 255, 255, 255), // Set background color to black
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true, // Allow ListView to size itself
                  itemCount: vehicleData.length,

                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(vehicleData[index]),
                      selected: _selectedManufacturer == vehicleData[index],
                      selectedTileColor: Color.fromARGB(255, 4, 207, 21),
                      onTap: () {
                        setState(() {
                          _selectedManufacturer =
                              vehicleData[index]; // Set the selected brand
                        });
                      },
                    );
                  },
                ),
                // Container(
                //   child: Expanded(
                //     child: ListView.separated(
                //       shrinkWrap: true, // Allow ListView to size itself
                //       itemCount: vehicleData.length,
                //       separatorBuilder: (context, index) => Divider(
                //         color: Colors.white, // Set separator color to white
                //       ),
                //       itemBuilder: (context, index) {
                //         return ListTile(
                //           title: Text(
                //             '${vehicleData[index]}',
                //             style: TextStyle(
                //                 color: Colors.white), // Set text color to white
                //           ),
                //           onTap: () {
                //             setState(() {
                //               _selectedManufacturer = vehicleData[index];

                //               print(_selectedManufacturer);
                //             });
                //             // Navigator.push(
                //             //   context,
                //             //   MaterialPageRoute(
                //             // builder: (context) => CarModelSelection(
                //             //   selectedManufacturer: _selectedManufacturer,
                //             // ),
                //             //   ),
                //             // );
                //           },
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the previous screen
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Previous',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Next screen
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
                child: Text('Next',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
