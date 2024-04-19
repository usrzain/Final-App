import 'package:effecient/navBar/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> with TickerProviderStateMixin {
  double _currentSliderValue = 20; // Fixed initial value
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  String _selectedCharge = 'Normal Charge'; // Initially selected charge
  Color _fastChargeColor =
      Colors.grey.shade900; // Initial color for Fast Charge button
  Color _normalChargeColor =
      Colors.blue; // Initial color for Normal Charge button (selected)

  bool isButtonClicked = false;
  bool isBillOpen = false; // Track if bill is open
// Function to add time to the current time
  String addTimeToCurrentTime(int hoursToAdd, int minutesToAdd) {
    DateTime now = DateTime.now();
    DateTime newTime =
        now.add(Duration(hours: hoursToAdd, minutes: minutesToAdd));
    String hour = newTime.hour < 10 ? '0${newTime.hour}' : '${newTime.hour}';
    String minute =
        newTime.minute < 10 ? '0${newTime.minute}' : '${newTime.minute}';
    String amPm = newTime.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $amPm';
  }

  // void _showBookingDetailsDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: ScaleTransition(
  //           scale: CurvedAnimation(
  //             parent: animationController,
  //             curve: Curves.fastOutSlowIn,
  //           ),
  //           child: Container(
  //             padding: EdgeInsets.all(20),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   'Booking Details',
  //                   style: TextStyle(
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 Text('Name of Customer: John Doe'),
  //                 Text('EV Name: Tesla Model S'),
  //                 Text('Token No: 123456'),
  //                 Text('Cost: $_selectedCharge'), // Update with actual cost
  //                 Text('Time to Reach: ${addTimeToCurrentTime(0, 35)}'),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // late AnimationController animationController;

  // @override
  // void initState() {
  //   super.initState();
  //   animationController = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 10),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text("Booking",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent)),
        ),
        backgroundColor: isBillOpen
            ? Colors.black.withOpacity(0.5)
            : Colors.black, // Lower transparency when bill is open
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8), // Add spacing
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 0.7),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                width: 400,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          // Icon widget
                          Icons
                              .electric_bolt, // You can change the icon as per your requirement
                          color: Colors.blue,
                          size: 24.0, // Adjust size as needed
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Select Your Charge Level',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RangeSlider(
                            values: RangeValues(
                                _currentSliderValue, _currentRangeValues.end),
                            min: 0.0,
                            max: 100.0,
                            divisions:
                                100, // Set divisions to match your scale sections
                            labels: RangeLabels(
                              _currentRangeValues.start.round().toString(),
                              _currentRangeValues.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _currentRangeValues = values;
                              });
                            },
                            activeColor: Colors.blue,
                            inactiveColor: Colors.grey,
                            // Add tick marks
                            // minorTicks:
                            //   true, // Enable minor ticks for each section
                            //  minorTickCount:
                            //     4, // Each section (25) can be divided into 4 minor ticks
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16), // Add spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              // Icon widget
                              Icons
                                  .battery_2_bar, // You can change the icon as per your requirement
                              color: Colors.redAccent,
                              size: 24.0, // Adjust size as needed
                            ),
                            Text(
                              'Battery At Arrival',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            '${_currentSliderValue // Fixed initial value
                                .round()}%',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              // Icon widget
                              Icons
                                  .battery_6_bar, // You can change the icon as per your requirement
                              color: Colors.greenAccent,
                              size: 24.0, // Adjust size as needed
                            ),
                            Text(
                              'Battery At Departure',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.7),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            '${_currentRangeValues.end.round()}%',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCharge = 'Fast Charge';
                          _fastChargeColor = Colors.blue;
                          _normalChargeColor = Colors.grey.shade900;
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.flash_on_outlined,
                            color: Colors.cyanAccent,
                            size: 20.0,
                          ),
                          //SizedBox(width: 4.0),
                          Flexible(
                            // Wrap text for potential overflow
                            child: Text(
                              'Fast Charge',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              overflow: TextOverflow
                                  .ellipsis, // Truncate with ellipsis if needed
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        side: BorderSide(color: Colors.white, width: 0.5),
                        backgroundColor: _fastChargeColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0), // Add a spacer between buttons
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedCharge = 'Normal Charge';
                          _fastChargeColor = Colors.grey.shade900;
                          _normalChargeColor = Colors.blue;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.electrical_services,
                            color: Colors.cyanAccent,
                            size: 20.0,
                          ),
                          //SizedBox(width: 4.0),
                          Flexible(
                            // Wrap text for potential overflow
                            child: Text(
                              'Normal Charge',
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                              overflow: TextOverflow
                                  .ellipsis, // Truncate with ellipsis if needed
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(color: Colors.white, width: 0.7),
                        backgroundColor: _normalChargeColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 8),
                      Text(
                        '∴  Cost of 1kwh for normal charge is Rs ',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  //SizedBox(width: 18),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 22), // Add left padding
                    child: Text(
                      'Cost of 1kwh for fast charge is Rs ',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16), // Add spacing
              // Text box with selected charge details (use Container for decoration)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 0.5),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    Icon(
                      // Icon widget
                      Icons
                          .attach_money, // You can change the icon as per your requirement
                      color: Colors.greenAccent,
                      size: 28.0, // Adjust size as needed
                    ),
                    Text(
                      ' Total Cost : \Rs ',
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontStyle: FontStyle.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16), // Add spacing
              // Booking time section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        // Added Row to include Icon and Text
                        children: [
                          Icon(
                            // Icon widget
                            Icons
                                .access_time, // You can change the icon as per your requirement
                            color: Colors.yellowAccent,
                            size: 24.0, // Adjust size as needed
                          ),
                          SizedBox(
                              width: 8.0), // Added space between icon and text
                          Text(
                            'Time To Reach',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.7),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '${addTimeToCurrentTime(0, 35)}', // Assuming this function returns the time to reach
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16), // Add spacing
              // Charge selection buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        //backgroundColor: isButtonClicked ? Colors.green : Colors.blue, // Change color based on click
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(
                            color: Colors.white, width: 0.3), // Add border
                      ),
                      backgroundColor: isButtonClicked
                          ? Colors.grey.shade900
                          : Colors
                              .blue, // Change color based on click, // Set button color dynamically
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isButtonClicked = true;
                        isBillOpen = true; // Open the bill
                      });

                      showDialog(
                        barrierDismissible:
                            false, // Prevent dismissing by tapping outside
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                            data: ThemeData(
                              brightness: Brightness.dark,
                              primaryColor: Colors.blue,
                            ),
                            child: AlertDialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(
                                    color: Colors.blue,
                                    width: 0.7), // Increased border width
                              ),
                              title: Text(
                                "Bill Details",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration.underline,
                                  // decorationColor: Colors.blue,
                                ),
                                textAlign:
                                    TextAlign.center, // Center align the title
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'John Doe',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'EV : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Tesla Model S',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Token No : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '12345',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Cost : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '\Rs 50',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time to Reach : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${addTimeToCurrentTime(0, 35)}',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Valid Till : ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${addTimeToCurrentTime(0, 70)}',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isBillOpen = false; // Close the bill
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Close',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                    width: 8.0), // Add spacing between buttons
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Save & Go',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Book & Navigate',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isButtonClicked ? Colors.blue : Colors.grey.shade900,
                      // Change color based on click
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: Colors.white, width: 0.3), // Add border
                      ),
                      //backgroundColor:
                      //_normalChargeColor, // Set button color dynamically
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isBillOpen
          ? GestureDetector(
              onTap: () {
                setState(() {
                  isBillOpen = false;
                });
              },
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            )
          : SizedBox(),
    ]);
  }
}
