import 'package:effecient/Auth/HomePage.dart';
import 'package:effecient/Auth/loginPage.dart';
import 'package:effecient/Data.dart';
import 'package:effecient/Providers/favStation.dart';
import 'package:effecient/Screens/Extra_Screens/booking.dart';
import 'package:effecient/Screens/Extra_Screens/profile.dart';
import 'package:effecient/Screens/Intro/SplashScreen.dart';
import 'package:effecient/WelcomePage.dart';
import 'package:effecient/dependency_injection.dart';
import 'package:effecient/navBar/animatedNavBar.dart';
import 'package:effecient/tab_contents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:effecient/Providers/chData.dart';

import 'package:effecient/Screens/CarSelection/carSelection.dart';

import 'package:effecient/Screens/CarSelection/carSelect.dart';
import 'package:effecient/Screens/Extra_Screens/intro1.dart';

import 'package:effecient/Screens/Intro/intro_screen.dart';

import 'package:effecient/Screens/PortSelection/EvPortSelectionScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //MAIN
  //runApp(MyApp(initialScreen: LoginPage()));
  // Preview the WelcomePage directly
  //runApp(MyApp(initialScreen: HomePage(user: User,)));

  // runApp(MyApp(initialScreen: MapScreen()));

  //runApp(MyApp(initialScreen: ProfileScreen()));

  //runApp(MyApp(initialScreen: CarSelect()));
  //runApp(MyApp(initialScreen: IntroScreen()));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => chDataProvider()),
      ChangeNotifierProvider(create: (context) => FavoriteStationsProvider())
    ],
    child: MyApp(
      initialScreen: SplashScreen(),
    ), // Your app's main widget
  ));
  DependencyInjection.init();
  // runApp(ChangeNotifierProvider(
  //   // Create an instance of YourDataProvider
  //   create: (context) => chDataProvider(),

  //   child: MyApp(initialScreen: SplashScreen()), // Your app's main widget
  // ));
  // runApp(MyApp(
  //     initialScreen: CurvedNavigationBar(
  //   items: [],
  // )));

  //runApp(MyApp(initialScreen: CarSelection()));

  //runApp(MyApp(initialScreen: EvPortSelectionScreen()));
}

class MyApp extends StatefulWidget {
  final Widget initialScreen;

  const MyApp({required this.initialScreen, Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? loggedInUser;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _hasSeenIntroSignupKey = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: widget.initialScreen,
      routes: {'/reservations': (context) => ReservationScreen()},
    );
  }
}
