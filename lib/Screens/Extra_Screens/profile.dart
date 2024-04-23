import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:effecient/Auth/loginPage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/CS_info_Screen/extraFun.dart';
import 'package:effecient/Screens/Intro/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? loggedInUser;
  @override
  initState() {
    super.initState();
    loggedInUser = FirebaseAuth.instance.currentUser;
    getUserDetails(loggedInUser!.email);
  }

  void getUserDetails(email) async {
    try {
      print('Welcome ');
      final emailQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      for (var doc in emailQuery.docs) {
        final userData = doc.data() as Map<String, dynamic>;
        // Access specific user details using keys in the map
        final name = userData['username'];
        final email =
            userData['email']; // This will be the same email used in the query
        // Access other user details based on field names
        Map<String, dynamic>? fetchUser = {'email': email, 'username': name};
        Provider.of<chDataProvider>(context, listen: false).userEmail = email;
        Provider.of<chDataProvider>(context, listen: false).userName = name;
        Provider.of<chDataProvider>(context, listen: false)
            .profileFetchingDone = true;
        print('$name');
      }
    } catch (error) {}
  }

  // Logout Function
  Future<void> logOut() async {
    try {
      // await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      // await GoogleSignIn().disconnect();

      // Navigate to the home page or desired screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<chDataProvider>(builder: (context, dataProvider, child) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Transparent app bar
          elevation: 0.0, // Remove shadow
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Profile heading
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 0.50),
                child: Text(
                  "My Profile", // Replace with your desired heading
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // User image section with gradient decoration
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: NetworkImage(
                            "https://placeimg.com/640/480/people"), // Replace with user's image URL
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.7),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center elements horizontally
                  children: [
                    Text(
                      "${dataProvider.userName}",
                      style: TextStyle(color: Colors.white, fontSize: 26.0),
                    ),
                    Text(
                      "${dataProvider.userEmail}",
                      style: TextStyle(color: Colors.grey, fontSize: 18.0),
                    ),
                  ],
                ),
              ),

              const Divider(
                height: 50,
                color: Colors.blueGrey,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              // Settings, Help, Logout, Delete list with larger fonts, icons, and arrows
              ListView.builder(
                shrinkWrap: true, // Prevent unnecessary scrolling
                physics: NeverScrollableScrollPhysics(), // Disable scrolling
                itemCount: 4,
                itemBuilder: (context, index) {
                  final String title;
                  final IconData icon;
                  switch (index) {
                    case 0:
                      title = "Settings";
                      icon = Icons.settings;
                      break;
                    case 1:
                      title = "Help";
                      icon = Icons.help_outline;
                      break;
                    case 2:
                      title = "Logout";
                      icon = Icons.exit_to_app;
                      break;
                    case 3:
                      title = "Delete Account";
                      icon = Icons.delete_outline;
                      break;
                    default:
                      title = "";
                      icon = Icons.error;
                  }
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        Icon(
                          Icons
                              .keyboard_arrow_right_outlined, // Small arrow icon
                          color: Colors.white54,
                          size: 32,
                        ),
                      ],
                    ),
                    leading: Icon(
                      icon,
                      color: Colors.blue,
                      size: 24.0, // Increased icon size
                    ),
                    onTap: () {
                      // Handle action based on title (e.g., navigate to settings screen)
                      switch (title) {
                        case 'Settings':
                          print("Clicked on $title");
                          break;
                        case 'Help':
                          Help(context);
                          break;
                        case 'Logout':
                          logOut();
                          break;
                        case "Delete Account":
                          print("Clicked on $title");
                          break;
                        // default:
                        //   title = "";
                        //   icon = Icons.error;
                      }
                    },
                  );
                },
              ),
              // Added "v1.0" text at the bottom
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "v1.0",
                    style: TextStyle(color: Colors.white54, fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> Help(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Help'),
          content: SingleChildScrollView(
            // Wrap content with SingleChildScrollView
            child: const Text(
              'Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation',
            ),
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
}
