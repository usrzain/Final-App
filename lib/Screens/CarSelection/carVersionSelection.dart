import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'detailsScreen.dart';

class CarVersionSelection extends StatefulWidget {
  final String selectedManufacturer;
  final String selectedModel;

  CarVersionSelection({
    required this.selectedManufacturer,
    required this.selectedModel,
  });

  @override
  _CarVersionSelectionState createState() => _CarVersionSelectionState();
}

class _CarVersionSelectionState extends State<CarVersionSelection> {
  late List<String> versions;

  @override
  void initState() {
    super.initState();
    versions = [];
    fetchVersions();
  }

  Future<void> fetchVersions() async {
    try {
      QuerySnapshot versionSnapshot = await FirebaseFirestore.instance
          .collection('version')
          .where('model', isEqualTo: widget.selectedModel)
          .where('brand', isEqualTo: widget.selectedManufacturer)
          .get();

      List<String> tempModels =
          versionSnapshot.docs.map((doc) => doc['version'].toString()).toList();

      setState(() {
        versions = tempModels;
      });
    } catch (e) {
      print('Error fetching versions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Version',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87, // Set background color to black
        child: ListView.separated(
          itemCount: versions.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.white, // Set separator color to white
            indent: 16, // Set left indentation
            endIndent: 16, // Set right indentation
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                versions[index],
                style:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      selectedManufacturer: widget.selectedManufacturer,
                      selectedModel: widget.selectedModel,
                      selectedVersion: versions[index],
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
