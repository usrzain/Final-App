import 'package:cool_alert/cool_alert.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/CarSelection/detailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'carVersionSelection.dart';

class CarModelSelection extends StatefulWidget {
  final String selectedManufacturer;

  CarModelSelection({required this.selectedManufacturer});

  @override
  _CarModelSelectionState createState() => _CarModelSelectionState();
}

class _CarModelSelectionState extends State<CarModelSelection> {
  List<String> modelData = ['2018', '2019', '2020'];
  String selectedModel = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchModels() async {
    try {
      QuerySnapshot modelsSnapshot = await FirebaseFirestore.instance
          .collection('model') // Assuming your collection is named 'models'
          .where('brand', isEqualTo: widget.selectedManufacturer)
          .get();

      List<String> tempModels =
          modelsSnapshot.docs.map((doc) => doc['model'].toString()).toList();
    } catch (e) {
      print('Error fetching models: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Model',
          style: TextStyle(color: Colors.blueAccent),
          textAlign: TextAlign.left,
        ),
        //
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              // Ensures the list fills available space
              child: Container(
                color: Colors.black87, // Set background color to black
                child: ListView.separated(
                  shrinkWrap: true, // Allow ListView to size itself
                  itemCount: modelData.length,
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.white, // Set separator color to white
                    indent: 16, // Set left indentation
                    endIndent: 16, // Set right indentation
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        ' ${modelData[index]}',
                        style: TextStyle(
                            color: Colors.white), // Set text color to white
                      ),
                      selected: selectedModel == modelData[index],
                      selectedTileColor: Color.fromARGB(
                          255, 4, 207, 21), // Green selected tile color
                      trailing: selectedModel == modelData[index]
                          ? Icon(Icons.check,
                              color: Colors.green) // Tick mark for selected row
                          : null,
                      onTap: () {
                        setState(() {
                          selectedModel =
                              modelData[index]; // Set the selected brand
                        });
                      },
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Navigate to the previous screen
                  },
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
                    if (selectedModel == "") {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: "Please choose Vehicle Model",
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            selectedManufacturer: widget.selectedManufacturer,
                            selectedModel: selectedModel,
                          ),
                        ),
                      );
                    }
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
