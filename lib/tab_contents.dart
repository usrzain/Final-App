import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/Extra_Screens/bookHistory.dart';
import 'package:effecient/Screens/Extra_Screens/favourites.dart';
import 'package:effecient/Screens/Extra_Screens/profile.dart';
import 'package:effecient/Screens/CS_info_Screen/mapScreenFinal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(child: MapScreen());
  }
}

class Tab2Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.green, // Color for Tab 2
          child: const Favourites()),
    );
  }
}

class Tab3Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.blue, // Color for Tab 3
        child: const BookHistory(),
      ),
    );
  }
}

class Tab4Content extends StatelessWidget {
  const Tab4Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileScreen(
          userName:
              Provider.of<chDataProvider>(context, listen: false).userName,
          userEmail:
              Provider.of<chDataProvider>(context, listen: false).userEmail),
    );
  }
}
