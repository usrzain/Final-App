// ignore_for_file: prefer_final_fields, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effecient/Auth/HomePage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/CarSelection/carSelect.dart';
import 'package:effecient/Screens/Extra_Screens/profile.dart';
import 'package:effecient/Screens/Intro/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _hasSeenIntroSignupKey = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>>? brands;
  Future<List<Map<String, dynamic>>>? models;
  @override
  void initState() {
    super.initState();
    fetchCollectionData('manufacturer', 'model');

    // print('Brands are ');
    // print(brands);
    // print(brands.runtimeType);
    // print('Models are ');
    // print(models);
    // print(models.runtimeType);

    // Simulate some initialization delay (replace with actual initialization)
    Future.delayed(const Duration(seconds: 10), () {
      // In Strting fetching some Fav Data from shared preferences
      // Navigate to the main screen after the delay

      checkFirstTime();
      Provider.of<chDataProvider>(context, listen: false).loggedInUser =
          FirebaseAuth.instance.currentUser;
    });
  }

  void fetchCollectionData(
      String collectionName, String collectionName2) async {
    List<Map<String, dynamic>> dataList = [];
    List<Map<String, dynamic>> dataList2 = [];

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      dataList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      QuerySnapshot querySnapshot2 =
          await _firestore.collection(collectionName2).get();
      dataList2 = querySnapshot2.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      Provider.of<chDataProvider>(context, listen: false).brandList = dataList;
      Provider.of<chDataProvider>(context, listen: false).modelList = dataList2;
      print(Provider.of<chDataProvider>(context, listen: false).brandList);
      print(Provider.of<chDataProvider>(context, listen: false).modelList);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchingFavStations() async {
    final SharedPreferences prefs = await _prefs;
  }

  Future<void> checkFirstTime() async {
    final SharedPreferences prefs = await _prefs;
    print('I am watching the Intro thing ');
    if (prefs.get('_hasSeenIntroSignupKey') != null) {
      // It shows that user has seen the Intro
      _hasSeenIntroSignupKey = true;
      Provider.of<chDataProvider>(context, listen: false).hasSeenTheIntro =
          true;
      Provider.of<chDataProvider>(context, listen: false)
          .initialLoadingComplete = true;
    } else {
      _hasSeenIntroSignupKey = false;
      Provider.of<chDataProvider>(context, listen: false).hasSeenTheIntro =
          false;
      Provider.of<chDataProvider>(context, listen: false)
          .initialLoadingComplete = true;
      // prefs.setBool('_hasSeenIntroSignupKey', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Consumer<chDataProvider>(builder: (context, dataProvider, child) {
          return dataProvider.initialLoadingComplete
              ? dataProvider.loggedInUser != null
                  ? HomePage(user: dataProvider.loggedInUser)

                  // : dataProvider.hasSeenTheIntro
                  //     ? dataProvider.loggedInUser != null
                  //         ? HomePage(user: dataProvider.loggedInUser)
                  //         : widget.initialScreen
                  : const IntroScreen()
              // : CarSelect()
              : LoadingScreen();
        })
      ],
    ));
  }
}

class LoadingScreen extends StatelessWidget {
  LoadingScreen({Key? key}) : super(key: key);

  final colorizeColors = [
    // Define colors directly
    Colors.white,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.purple,
  ];

  final colorizeTextStyle = const TextStyle(
    // Define text style as constant
    fontSize: 30.0,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20.0), // Top padding

                Image.asset(
                  'assets/pin-point_9537049.png', // Adjust image path accordingly
                  height: 300, // Adjust image height as needed
                ),

                // Animated TextLiquidFill for "Flutter"
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 65,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 45,
                    ),
                    child: AnimatedTextKit(
                      repeatForever: false,
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TyperAnimatedText('EV NAV'),
                        // TyperAnimatedText('courses, youtube'),
                        // TyperAnimatedText('and many more.'),
                      ],
                    ),
                  ),
                ),

                //const SizedBox(height: 20.0), // Spacing between animations

                // Animated TextKit with ColorizeAnimatedText
                SizedBox(
                  //height: 70,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    isRepeatingAnimation: true,
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Find',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        'Charge',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                      ColorizeAnimatedText(
                        '& Enjoy',
                        textStyle: colorizeTextStyle,
                        colors: colorizeColors,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20.0), // Spacing between animations

                // Loader (CircularProgressIndicator)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CircularProgressIndicator(
                    color: Colors.blueAccent, // Adjust color as needed
                  ),
                ),

                const SizedBox(height: 20.0), // Bottom padding
                // Static Text for "v1.0"
                const Text(
                  'v1.0',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),

                const SizedBox(height: 20.0), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage(
//                 'assets/Intro/EVNav_.png'), // Replace with your image path
//             fit: BoxFit.cover, // Fills the entire screen proportionally
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Optional: App logo or text content on top (centered)
//               // Text(
//               //   "My Awesome App",
//               //   style: TextStyle(color: Colors.white, fontSize: 24.0),
//               // ),
//               const SizedBox(height: 500.0),
//               // Loader animation with some spacing
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: CircularProgressIndicator(
//                   color: Colors.blueAccent, // Adjust color as needed
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
