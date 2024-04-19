import 'package:effecient/Screens/Extra_Screens/favourites.dart';
import 'package:effecient/Screens/Extra_Screens/profile.dart';
import 'package:effecient/Screens/CS_info_Screen/mapScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:effecient/Screens/Extra_Screens/booking.dart';

class Tab1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: MapScreen());
  }
}

class Tab2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.green, // Color for Tab 2
          child: Favourites()),
    );
  }
}

class Tab3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue, // Color for Tab 3
        child: Booking(),
      ),
    );
  }
}

class Tab4Content extends StatelessWidget {
  const Tab4Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.orange, // Color for Tab 4
        child: ProfileScreen(),
      ),
    );
  }
}
