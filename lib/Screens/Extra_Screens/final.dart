import 'package:effecient/navBar/colors/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:effecient/Providers/chData.dart';

class Booking extends StatefulWidget {
  final int? timetaken;
  final double? currentSliderValue;
  final double? costPerKWH;
  final double? kWHOnepercent;
  final Map<String, dynamic>? stationList;
  const Booking(
      {Key? key,
      this.timetaken,
      this.currentSliderValue,
      this.costPerKWH,
      this.kWHOnepercent,
      this.stationList})
      : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> with TickerProviderStateMixin {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  dynamic _selectedCharge = null; // Initially selected charge
  Color _fastChargeColor =
      Colors.grey.shade900; // Initial color for Fast Charge button
  Color _normalChargeColor =
      Colors.blue; // Initial color for Normal Charge button (selected)
  double totalCost = 0.0;

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
    double currentCharge = widget.currentSliderValue!;
    double costperkwh = widget.costPerKWH!;
    double KwhForOnePercent = widget.kWHOnepercent!;
    Map<String, dynamic> stationList = widget.stationList!;
    DateTime now = DateTime.now(); // Using var instead of final
    Duration durationToAdd =
        Duration(minutes: widget.timetaken! + 5); // No change

    DateTime futureTime = now.add(durationToAdd);
    String arrivalTime = futureTime.toString().substring(11, 16);
    bool allowToBook = false;
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
                                currentCharge, _currentRangeValues.end),
                            min: currentCharge,
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
                                totalCost = costperkwh *
                                    KwhForOnePercent *
                                    (_currentRangeValues.end.round() -
                                        currentCharge.round());
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
                            '${currentCharge // Fixed initial value
                                .round() <= 0 ? '1' : currentCharge.round()}%',
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
                          Provider.of<chDataProvider>(context, listen: false)
                              .allowToBook = true;
                          _selectedCharge = 'Fast Charge';
                          print('Selected Charge is ${_selectedCharge}');
                          _fastChargeColor =
                              Colors.blue; // Change color to blue on selection
                          _normalChargeColor = Colors
                              .grey.shade900; // Deselect normal charge color
                          print('before 5 percent');
                          print(costperkwh);
                          costperkwh = (costperkwh + (costperkwh * 5 / 100));
                          print('after 5 percent');
                          print(costperkwh);

                          print('Charging percent wanted ');
                          print(_currentRangeValues.end.round() -
                              currentCharge.round());

                          totalCost = costperkwh *
                              KwhForOnePercent *
                              (_currentRangeValues.end.round() -
                                  currentCharge.round());

                          print('totla cost ');
                          print(totalCost);
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
                          Provider.of<chDataProvider>(context, listen: false)
                              .allowToBook = true;
                          _selectedCharge = 'Normal Charge';
                          print('Selected Charge is ${_selectedCharge}');
                          _fastChargeColor = Colors
                              .grey.shade900; // Deselect fast charge color
                          _normalChargeColor =
                              Colors.blue; // Change color to blue on selection
                          totalCost = costperkwh *
                              KwhForOnePercent *
                              (_currentRangeValues.end.round() -
                                  currentCharge.round());
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
                        '∴  Cost of 1kwh for normal charge is Rs ${costperkwh}',
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
                      'Cost of 1kwh for fast charge is Rs ${(costperkwh + (costperkwh * 5 / 100))}',
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
                      ' Total Cost : Rs ${totalCost.toInt()} ',
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
                          arrivalTime, // Assuming this function returns the time to reach
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
                      // print(_selectedCharge);
                      // if (_selectedCharge != null) {
                      //   print(_selectedCharge);
                      // } else {
                      //   print('select the Charging type');
                      // }
                      if (_selectedCharge != null) {
                        Map<String, dynamic> object = stationList['CS1'];
                        String Title = object['title'];
                        String tokenNum =
                            Provider.of<chDataProvider>(context, listen: false)
                                .generateRandomNumber();
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
                                  textAlign: TextAlign
                                      .center, // Center align the title
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Name : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${Provider.of<chDataProvider>(context, listen: false).userName}',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'EV : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${Provider.of<chDataProvider>(context, listen: false).vehBrand} Model ${Provider.of<chDataProvider>(context, listen: false).vehModel}',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Token No : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          tokenNum,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Station Name',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          Title,
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cost : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Rs ${totalCost.toInt()}',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Time to Reach : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${arrivalTime}',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Valid Till : ',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          arrivalTime,
                                          style:
                                              TextStyle(color: Colors.white70),
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
                                      width:
                                          8.0), // Add spacing between buttons
                                  ElevatedButton(
                                    onPressed: () async {
                                      double lati = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedLatitude;
                                      String title =
                                          Provider.of<chDataProvider>(context,
                                                  listen: false)
                                              .selectedStation;
                                      double long = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedLongitude;
                                      String key = Provider.of<chDataProvider>(
                                              context,
                                              listen: false)
                                          .selectedKey;

                                      updateSpecificValue(stationList, key);
                                      Provider.of<chDataProvider>(context,
                                              listen: false)
                                          .addBookings(title, tokenNum,
                                              arrivalTime, totalCost);
                                      MapsLauncher.launchCoordinates(
                                          lati, long, title);
                                    },
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
                      } else {
                        selectAlert(context);
                      }
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

  Future<void> selectAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text(
            'Select a type of Charging for proper cost calculation',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Future<void> updateSpecificValue(String objectId, dynamic newValue) async {
  //   DatabaseReference _databaseReference =
  //       FirebaseDatabase.instance.ref().child('Locations/$objectId');

  //   // Update the specific key with the new value
  //   await _databaseReference.update({'available_slots': newValue});
  // }

  Future<void> updateSpecificValue(
      Map<String, dynamic> stationList, String key) async {
    DatabaseReference _databaseReference =
        FirebaseDatabase.instance.ref().child('Locations/$key');
    print(key);
    try {
      print(stationList.containsKey(key));
      Map<String, dynamic> object = stationList[key];
      print(object['available_slots']);
      int newValue = 0;
      if (object['available_slots'] == 0) {
        newValue = object['queue'] + 1;
        // Update the specific key with the new value
        await _databaseReference.update({'queue': newValue});
      } else {
        newValue = object['available_slots'] - 1;
        // Update the specific key with the new value
        await _databaseReference.update({'available_slots': newValue});
      }
    } catch (error) {
      print('cannot find it ');
    }
  }
}
