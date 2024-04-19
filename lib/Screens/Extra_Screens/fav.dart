import 'package:effecient/navBar/colors/colors.dart';
import 'package:flutter/material.dart';

class ChargingStation {
  final String name;
  final String address;
  final double cost;

  ChargingStation(
      {required this.name, required this.address, required this.cost});
}

class Saved extends StatelessWidget {
  final List<ChargingStation> chargingStations = [
    ChargingStation(name: "ChargeUp", address: "123 Main St", cost: 10.0),
    ChargingStation(name: "PowerCharge", address: "456 Elm St", cost: 8.0),
    ChargingStation(name: "ElectroHub", address: "789 Oak St", cost: 12.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.ev_station,
              color: white,
            ),
            // Charging station icon

            SizedBox(width: 8), // Add some spacing between icon and text
            Text(
              'Saved Charging Stations',
              style: TextStyle(
                color: Colors.white, // White text color
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black, // Black background
      ),
      body: Container(
        color: Colors.black, // Black background for the body
        child: ListView.builder(
          itemCount: chargingStations.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.black, // Grey color for the card
                border:
                    Border.all(color: Colors.blue, width: 0.75), // Blue border
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
              child: Card(
                elevation: 0, // No elevation to avoid shadow overlap
                color: Colors.transparent, // Transparent color for the card
                child: ListTile(
                  title: Text(
                    chargingStations[index].name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text color
                      fontSize: 24,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.red), // Location icon
                          SizedBox(width: 4),
                          Text(
                            chargingStations[index].address,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                              fontSize: 18, // White text color
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.attach_money,
                              color: Colors.green), // Cost icon
                          SizedBox(width: 4),
                          Text(
                            'Cost: \$${chargingStations[index].cost.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
