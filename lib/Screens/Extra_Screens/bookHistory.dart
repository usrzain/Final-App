// ignore_for_file: library_private_types_in_public_api

import 'package:effecient/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookHistory extends StatefulWidget {
  const BookHistory({Key? key}) : super(key: key);

  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Booking History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text color
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.black),
        body: Stack(
          children: [
            Consumer<chDataProvider>(builder: (context, dataProvider, child) {
              return Container(
                color: Colors.black, // Black background for the body
                child: ListView.builder(
                  itemCount: dataProvider.bookings.entries.length,
                  itemBuilder: (context, index) {
                    if (dataProvider.bookings.entries.isEmpty) {
                      return const Text('No Booking yet');
                    } else {
                      // print(dataProvider.favStations.entries);
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black, // Grey color for the card
                          border: Border.all(
                              color: Colors.blue, width: 0.75), // Blue border
                          borderRadius:
                              BorderRadius.circular(8), // Rounded corners
                        ),
                        child: Card(
                          elevation: 0, // No elevation to avoid shadow overlap
                          color: Colors
                              .transparent, // Transparent color for the card
                          child: ListTile(
                            title: Text(
                              dataProvider.bookings.entries
                                  .elementAt(index)
                                  .value['title'],
                              style: const TextStyle(
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
                                    const Icon(Icons.location_on,
                                        color: Colors.red), // Location icon
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        dataProvider.bookings.entries
                                            .elementAt(index)
                                            .value['address'],
                                        style: const TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontSize: 18,
                                          // White text color
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money,
                                        color: Colors.green), // Cost icon
                                    const SizedBox(width: 4),
                                    Text(
                                      'Booked on: ${dataProvider.bookings.entries.elementAt(index).value['Booked on'].toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money,
                                        color: Colors.green), // Cost icon
                                    const SizedBox(width: 4),
                                    Text(
                                      'Reach until: ${dataProvider.bookings.entries.elementAt(index).value['time'].toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money,
                                        color: Colors.green), // Cost icon
                                    const SizedBox(width: 4),
                                    Text(
                                      'Token No: ${dataProvider.bookings.entries.elementAt(index).value['token'].toString()}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money,
                                        color: Colors.green), // Cost icon
                                    const SizedBox(width: 4),
                                    Text(
                                      'total cost: \$${dataProvider.bookings.entries.elementAt(index).value['total cost'].toStringAsFixed(2)}',
                                      style: const TextStyle(
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
                    }
                  },
                ),
              );
            })
          ],
        ));
  }
}
