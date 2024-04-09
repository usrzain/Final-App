// ignore_for_file: use_build_context_synchronously

import 'package:effecient/Auth/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'tab_contents.dart';

class MyTabScreen extends StatefulWidget {
  //final User? user;

  //const MyTabScreen({Key? key, required this.user}) : super(key: key);
  @override
  _MyTabScreenState createState() => _MyTabScreenState();
}

class _MyTabScreenState extends State<MyTabScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigate to the '),
        actions: [
          logoutButton(context),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Tab1Content(),
          Tab2Content(),
          Tab3Content(),
          //Tab4Content(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Change the selected item color
        unselectedItemColor: Colors.grey, // Change the unselected item color
        backgroundColor: Colors.white, // C
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Tab 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Tab 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tab 4',
          ),
        ],
      ),
    );
  }

  ElevatedButton logoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Text('Logout'),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
