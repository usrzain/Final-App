// ignore_for_file: library_private_types_in_public_api

import 'package:effecient/Providers/chData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookHistory extends StatefulWidget {
  const BookHistory({Key? key}) : super(key: key);

  @override
  _BookHistoryState createState() => _BookHistoryState();
}

class _BookHistoryState extends State<BookHistory> {
  String formatTimestamp(Timestamp timestamp) {
    // Convert Firestore Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();
    // Format the timestamp as a string
    String formattedDateTime =
        DateFormat('MMMM d, y hh:mm:ss a').format(dateTime);
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black, // Black background for the body
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.black, // Black background
                  child: Text(
                    'Booking History', // Text "your cs" above the cards
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue, // Blue font color
                      fontSize: 26,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1, // Adjust thickness as needed
                  color: Colors.grey, // Set color
                  indent: 20.0, // Left padding
                  endIndent: 20.0, // Right padding
                ),
                Expanded(
                  child: Consumer<chDataProvider>(
                    builder: (context, dataProvider, child) {
                      if (dataProvider.bookings.entries.isEmpty) {
                        // If favourites list is empty, show image with text
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/Business.png', // Path to your image asset
                                height: 250,
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Don't Have Any thing in History Yet",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // If there are favourites, show the list
                        return ListView.builder(
                          itemCount: dataProvider.bookings.entries.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.black, // Grey color for the card
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 0.75), // Blue border
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                              child: Card(
                                elevation:
                                    0, // No elevation to avoid shadow overlap
                                color: Colors
                                    .transparent, // Transparent color for the card
                                child: ListTile(
                                  title: Text(
                                    dataProvider.bookings.entries
                                        .elementAt(index)
                                        .value['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white, // White text color
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on,
                                              color:
                                                  Colors.red), // Location icon
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
                                            'Booked on: ${formatTimestamp(dataProvider.bookings.entries.elementAt(index).value['Booked on'])}',
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
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
