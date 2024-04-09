import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'carVersionSelection.dart';

class CarModelSelection extends StatefulWidget {
  final String selectedManufacturer;

  CarModelSelection({required this.selectedManufacturer});

  @override
  _CarModelSelectionState createState() => _CarModelSelectionState();
}

class _CarModelSelectionState extends State<CarModelSelection> {
  late List<String> modelsData;

  @override
  void initState() {
    super.initState();
    modelsData = [];
    fetchModels();
  }

  Future<void> fetchModels() async {
    try {
      QuerySnapshot modelsSnapshot = await FirebaseFirestore.instance
          .collection('model') // Assuming your collection is named 'models'
          .where('brand', isEqualTo: widget.selectedManufacturer)
          .get();

      List<String> tempModels =
          modelsSnapshot.docs.map((doc) => doc['model'].toString()).toList();

      setState(() {
        modelsData = tempModels;
      });
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87, // Set background color to black
        child: ListView.separated(
          itemCount: modelsData.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white, // Set separator color to white
            indent: 16, // Set left indentation
            endIndent: 16, // Set right indentation
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                modelsData[index],
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarVersionSelection(
                      selectedManufacturer: widget.selectedManufacturer,
                      selectedModel: modelsData[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
