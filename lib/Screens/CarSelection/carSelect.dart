import 'package:effecient/Screens/CarSelection/carSelection.dart';
import 'package:flutter/material.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class CarSelect extends StatefulWidget {
  const CarSelect({Key? key}) : super(key: key);

  @override
  _CarSelectState createState() => _CarSelectState();
}

class _CarSelectState extends State<CarSelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.black,
          elevation: 2, // Add a small shadow
          title: Text(
            'Select Your Car',
            style: TextStyle(fontSize: 40, color: Colors.blueAccent),
          ),
          centerTitle: true, // Align title text to the center
        ),
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70,
                  child: DefaultTextStyle(
                    style: TextStyle(
                        color: Color.fromARGB(255, 4, 164, 73),
                        fontSize: 30,
                        fontWeight: FontWeight.w100),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Personalize your experience\n'
                          'by adding a vehicle',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/electric-carSelect.png',
              // Replace with your image asset path
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.black,
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue, // Set button color to blue
                        ),
                        child: Text('Previous',
                            style: TextStyle(color: Colors.white)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle next screen navigation
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => CarSelection()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.blue, // Set button color to blue
                        ),
                        child:
                            Text('Next', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
