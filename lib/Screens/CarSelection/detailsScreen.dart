import 'package:flutter/material.dart';
import 'package:effecient/Screens/PortSelection/EvPortSelectionScreen.dart';

class DetailsScreen extends StatefulWidget {
  final String selectedManufacturer;
  final String selectedModel;
  final String selectedVersion;

  DetailsScreen({
    required this.selectedManufacturer,
    required this.selectedModel,
    required this.selectedVersion,
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
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
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
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manufacturer: ${widget.selectedManufacturer}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Model: ${widget.selectedModel}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    'Version: ${widget.selectedVersion}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Additional Details:',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    additionalDetails ?? 'Loading...',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EvPortSelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(
                  double.infinity, // Full width
                  48.0,
                ),
              ),
              child: Text('Select',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
