import 'package:flutter/material.dart';

class EvPortSelectionScreen extends StatefulWidget {
  @override
  _EvPortSelectionScreenState createState() => _EvPortSelectionScreenState();
}

class _EvPortSelectionScreenState extends State<EvPortSelectionScreen> {
  List<String> evPortTypes = [
    'Type 1',
    'Type 2',
    'CHAdeMO',
    'CCS',
    'Tesla Supercharger',
  ];

  String selectedPortType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Port Selection'),
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            // Image portion at the top
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/charging-station_5396703.png'), // Add your image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Chip portion
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select EV Port Type:',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: evPortTypes.map((portType) {
                        return ChoiceChip(
                          label: Text(
                            portType,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.grey,
                          selected: selectedPortType == portType,
                          onSelected: (selected) {
                            setState(() {
                              selectedPortType = selected ? portType : '';
                            });
                          },
                          selectedColor: Colors.blue,
                          labelStyle: TextStyle(color: Colors.white),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Port Type: ',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        Text(
                          '${selectedPortType.isEmpty ? 'None' : selectedPortType}',
                          style: TextStyle(
                              fontSize: 16,
                              color: selectedPortType.isNotEmpty
                                  ? Colors.blue
                                  : Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic when the "Select" button is pressed
                            if (selectedPortType.isNotEmpty) {
                              // Handle the selection
                              print('Port type selected: $selectedPortType');
                            } else {
                              // No port type selected, show a message or perform an action
                              print('No port type selected');
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: selectedPortType.isNotEmpty
                                ? MaterialStateProperty.all(Colors.blue)
                                : MaterialStateProperty.all(Colors.grey),
                            overlayColor:
                                MaterialStateProperty.all(Colors.blue),
                            side: MaterialStateProperty.all(
                                BorderSide(color: Colors.blue, width: 2)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 16),
                    // Text(
                    //   'Selected Port Type: ${selectedPortType.isEmpty ? 'None' : selectedPortType}',
                    //   style: TextStyle(fontSize: 16, color: Colors.white),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
