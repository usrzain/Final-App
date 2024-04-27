// ignore_for_file: prefer_final_fields, unused_field

import 'package:effecient/Auth/HomePage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/Extra_Screens/profile.dart';
import 'package:effecient/Screens/Intro/intro_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _hasSeenIntroSignupKey = false;
  @override
  void initState() {
    super.initState();

    // Simulate some initialization delay (replace with actual initialization)
    Future.delayed(const Duration(seconds: 5), () {
      // In Strting fetching some Fav Data from shared preferences
      // Navigate to the main screen after the delay
      checkFirstTime();
      Provider.of<chDataProvider>(context, listen: false).loggedInUser =
          FirebaseAuth.instance.currentUser;
    });
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
              : const LoadingScreen();
        })
      ],
    ));
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/Intro/EVNav_.png'), // Replace with your image path
          fit: BoxFit.cover, // Fills the entire screen
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Optional: App logo or text content on top
            // ... your widgets here ...
            const SizedBox(height: 400.0),
            // Loader animation
            CircularProgressIndicator(
              color: Colors.white, // Adjust color as needed
            ),
          ],
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
