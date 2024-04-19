import 'package:effecient/Providers/chData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _BookingReservationScreenState createState() =>
      _BookingReservationScreenState();
}

class _BookingReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return Booking(
        timetaken: Provider.of<chDataProvider>(context, listen: false)
            .timeTaken!
            .toInt(),
        currentSliderValue: Provider.of<chDataProvider>(context, listen: false)
            .arrivalBattery(),
        costPerKWH:
            Provider.of<chDataProvider>(context, listen: false).perKWHCost,
        kWHOnepercent: Provider.of<chDataProvider>(context, listen: false)
            .getKwhForOnePercent());
  }
}

class Booking extends StatefulWidget {
  final int? timetaken;
  final double? currentSliderValue;
  final double? costPerKWH;
  final double? kWHOnepercent;
  const Booking(
      {Key? key,
      this.timetaken,
      this.currentSliderValue,
      this.costPerKWH,
      this.kWHOnepercent})
      : super(key: key);

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
  String _selectedCharge = 'Normal Charge'; // Initially selected charge
  Color _fastChargeColor =
      Colors.grey.shade900; // Initial color for Fast Charge button
  Color _normalChargeColor =
      Colors.blue; // Initial color for Normal Charge button (selected)
  double totalCost = 0.0;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _currentSliderValue = Provider.of<chDataProvider>(context, listen: false)
  //       .stateOfCharge!
  //       .toDouble();
  // }

  @override
  Widget build(BuildContext context) {
    double currentCharge = widget.currentSliderValue!;
    double costperkwh = widget.costPerKWH!;
    double KwhForOnePercent = widget.kWHOnepercent!;
    DateTime now = DateTime.now(); // Using var instead of final
    Duration durationToAdd =
        Duration(minutes: widget.timetaken! + 5); // No change

    DateTime futureTime = now.add(durationToAdd);
    String arrivalTime = futureTime.toString().substring(11, 16);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Booking",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                      Text(
                        'Select your charge level',
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
                          values: RangeValues(currentCharge,
                              _currentRangeValues.end), // Fix initial value
                          min: currentCharge, // Set minimum value explicitly
                          max: 100,
                          divisions: 100,
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Add spacing
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Battery at arrival',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.7),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          '${currentCharge // Fixed initial value
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
                      Text(
                        'Battery at departure',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white),
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
            const SizedBox(height: 16),
            // Divider(
            //   color: Colors.white,
            //   thickness: 1,
            //   indent: 16,
            //   endIndent: 16,
            // ),
            const SizedBox(height: 16), // Add spacing
            // Charge selection buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCharge = 'Fast Charge';
                      _fastChargeColor =
                          Colors.blue; // Change color to blue on selection
                      _normalChargeColor =
                          Colors.grey.shade900; // Deselect normal charge color
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
                  child: Text(
                    'Fast Charge',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                          color: Colors.white, width: 0.5), // Add border
                    ),
                    backgroundColor:
                        _fastChargeColor, // Set button color dynamically
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.white), // Add border
                //     borderRadius: BorderRadius.circular(10.0),
                //   ),
                // padding: const EdgeInsets.all(8.0),
                // child:
                Text(
                  ' OR ',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedCharge = 'Normal Charge';
                      _fastChargeColor =
                          Colors.grey.shade900; // Deselect fast charge color
                      _normalChargeColor =
                          Colors.blue; // Change color to blue on selection
                      totalCost = costperkwh *
                          KwhForOnePercent *
                          (_currentRangeValues.end.round() -
                              currentCharge.round());
                    });
                  },
                  child: Text(
                    'Normal Charge',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.white), // Add border
                    ),
                    backgroundColor:
                        _normalChargeColor, // Set button color dynamically
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16), // Add spacing
            // Text box with selected charge details (use Container for decoration)
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black,
              ),
              child: Text(
                'Your total cost for $totalCost is',
                style: const TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16), // Add spacing
            // Booking time section

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Booking Time', style: TextStyle(color: Colors.white)),
                // Add a Text widget to display booking time (replace with your implementation)
                Text(arrivalTime, style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
