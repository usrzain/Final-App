// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:effecient/Auth/loginPage.dart';
// import 'package:effecient/Providers/chData.dart';
// import 'package:effecient/Screens/CS_info_Screen/extraFun.dart';
// import 'package:effecient/Screens/Intro/splashScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatefulWidget {
//   final String? userName;
//   final String? userEmail;
//   const ProfileScreen(
//       {Key? key, required this.userName, required this.userEmail})
//       : super(key: key);
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User? loggedInUser;
//   @override
//   initState() {
//     super.initState();
//     loggedInUser = FirebaseAuth.instance.currentUser;
//     getUserDetails(loggedInUser!.email);
//   }

//   void getUserDetails(email) async {
//     try {
//       print('Welcome ');
//       final emailQuery = await FirebaseFirestore.instance
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .get();

//       for (var doc in emailQuery.docs) {
//         final userData = doc.data() as Map<String, dynamic>;
//         // Access specific user details using keys in the map
//         final name = userData['username'];
//         final email =
//             userData['email']; // This will be the same email used in the query
//         // Access other user details based on field names
//         Map<String, dynamic>? fetchUser = {'email': email, 'username': name};
//         Provider.of<chDataProvider>(context, listen: false).userEmail = email;
//         Provider.of<chDataProvider>(context, listen: false).userName = name;
//         Provider.of<chDataProvider>(context, listen: false)
//             .profileFetchingDone = true;
//         print('$name');
//       }
//     } catch (error) {}
//   }

//   // Logout Function
//   Future<void> logOut() async {
//     try {
//       // await _googleSignIn.signOut();
//       await _firebaseAuth.signOut();
//       // await GoogleSignIn().disconnect();

//       // Navigate to the home page or desired screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const LoginPage()),
//       );
//     } catch (e) {
//       print('Error signing out: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<chDataProvider>(builder: (context, dataProvider, child) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent, // Transparent app bar
//           elevation: 0.0, // Remove shadow
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Profile heading
//               Padding(
//                 padding: const EdgeInsets.only(top: 5.0, bottom: 0.50),
//                 child: Text(
//                   "My Profile", // Replace with your desired heading
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 32.0,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               // User image section with gradient decoration
//               Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Center(
//                       child: CircleAvatar(
//                         radius: 50.0,
//                         backgroundImage: NetworkImage(
//                             "https://placeimg.com/640/480/people"), // Replace with user's image URL
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50.0),
//                       gradient: LinearGradient(
//                         colors: [
//                           Colors.black.withOpacity(0.7),
//                           Colors.transparent
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//                 child: Column(
//                   crossAxisAlignment:
//                       CrossAxisAlignment.center, // Center elements horizontally
//                   children: [
//                     Text(
//                       "${widget.userName}",
//                       style: TextStyle(color: Colors.white, fontSize: 26.0),
//                     ),
//                     Text(
//                       "${widget.userEmail}",
//                       style: TextStyle(color: Colors.grey, fontSize: 18.0),
//                     ),
//                   ],
//                 ),
//               ),

//               const Divider(
//                 height: 50,
//                 color: Colors.blueGrey,
//                 thickness: 5,
//                 indent: 20,
//                 endIndent: 20,
//               ),
//               // Settings, Help, Logout, Delete list with larger fonts, icons, and arrows
//               ListView.builder(
//                 shrinkWrap: true, // Prevent unnecessary scrolling
//                 physics: NeverScrollableScrollPhysics(), // Disable scrolling
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   final String title;
//                   final IconData icon;
//                   switch (index) {
//                     case 0:
//                       title = "Settings";
//                       icon = Icons.settings;
//                       break;
//                     case 1:
//                       title = "Help";
//                       icon = Icons.help_outline;
//                       break;
//                     case 2:
//                       title = "Logout";
//                       icon = Icons.exit_to_app;
//                       break;
//                     case 3:
//                       title = "Delete Account";
//                       icon = Icons.delete_outline;
//                       break;
//                     default:
//                       title = "";
//                       icon = Icons.error;
//                   }
//                   return ListTile(
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           title,
//                           style: TextStyle(color: Colors.white, fontSize: 18.0),
//                         ),
//                         Icon(
//                           Icons
//                               .keyboard_arrow_right_outlined, // Small arrow icon
//                           color: Colors.white54,
//                           size: 32,
//                         ),
//                       ],
//                     ),
//                     leading: Icon(
//                       icon,
//                       color: Colors.blue,
//                       size: 24.0, // Increased icon size
//                     ),
//                     onTap: () {
//                       // Handle action based on title (e.g., navigate to settings screen)
//                       switch (title) {
//                         case 'Settings':
//                           print("Clicked on $title");
//                           break;
//                         case 'Help':
//                           Help(context);
//                           break;
//                         case 'Logout':
//                           logOut();
//                           break;
//                         case "Delete Account":
//                           print("Clicked on $title");
//                           break;
//                         // default:
//                         //   title = "";
//                         //   icon = Icons.error;
//                       }
//                     },
//                   );
//                 },
//               ),
//               // Added "v1.0" text at the bottom
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Text(
//                     "v1.0",
//                     style: TextStyle(color: Colors.white54, fontSize: 16.0),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Future<void> Help(BuildContext context) {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Help'),
//           content: SingleChildScrollView(
//             // Wrap content with SingleChildScrollView
//             child: const Text(
//               'Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation.Select a type of Charging for proper cost calculation',
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               style: TextButton.styleFrom(
//                 textStyle: Theme.of(context).textTheme.labelLarge,
//               ),
//               child: const Text('ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:effecient/Auth/loginPage.dart';
import 'package:effecient/Providers/chData.dart';
import 'package:effecient/Screens/CS_info_Screen/extraFun.dart';
import 'package:effecient/Screens/CarSelection/carSelect.dart';
import 'package:effecient/Screens/Intro/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class ProfileScreen extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  const ProfileScreen(
      {Key? key, required this.userName, required this.userEmail})
      : super(key: key);
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

  final colorizeColors = [
    //Colors.black,
    Colors.blue,
    Colors.orange,
    Colors.red,
    Colors.greenAccent,
    Color.fromARGB(255, 0, 242, 255)
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
  );

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
              SizedBox(
                height: 70,
                child: AnimatedTextKit(
                  repeatForever: false,
                  isRepeatingAnimation: true,
                  totalRepeatCount: 20,
                  animatedTexts: [
                    ColorizeAnimatedText(
                      'My Profile',
                      textStyle: colorizeTextStyle,
                      speed: Duration(seconds: 1),
                      colors: colorizeColors,
                    ),
                  ],
                ),
              ),
              // User image section with gradient decoration
              Stack(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(20.0),
                  //   child: Center(
                  //     child: CircleAvatar(
                  //       radius: 50.0,
                  //       backgroundImage: NetworkImage(
                  //           "https://placeimg.com/640/480/people"), // Replace with user's image URL
                  //     ),
                  //   ),
                  // ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.orangeAccent,
                          size: 26.0,
                        ),
                        SizedBox(
                            width: 5), // Adding space between icon and text
                        Text(
                          "Hi, ${widget.userName}",
                          style: TextStyle(color: Colors.white, fontSize: 26.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.directions_car,
                          color: Colors.greenAccent,
                          size: 18.0,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${dataProvider.defaultBrand} ${dataProvider.defaultModel}",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.redAccent,
                          size: 18.0,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${widget.userEmail}",
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ],
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
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.blue,
                                          width: 0.7), // Blue border color
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust border radius as needed
                                    ),
                                    backgroundColor: Colors.black,
                                    content: openFilterModal(context),
                                  ));
                          print("Clicked on $title");
                          break;
                        case 'Help':
                          Help(context);
                          break;
                        case 'Logout':
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.confirm,
                            confirmBtnText: 'Yes',
                            cancelBtnText: 'No',
                            onConfirmBtnTap: () {
                              logOut();
                            },
                          );

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

  Widget openFilterModal(BuildContext context) {
    int? userInput;
    String? selectedTitle = '';
    String? selectedSecondTitle = '';
    int currentValue = 0;
    String? selectedModalType; // Move the declaration here

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        RangeValues _currentRangeValues = const RangeValues(0, 100);

        return Container(
          color: Colors.black, // Background color
          child: SingleChildScrollView(
            child: Stack(children: [
              Container(
                //color: Colors.black, // Background color

                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Show "Select Model" and "Select Brand" only when "Extra" is selected
                      Text('Default EV',
                          style: TextStyle(
                              fontSize: 22, color: Colors.blueAccent)),
                      SizedBox(height: 20),
                      Text(
                        'Select Brand :',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Wrap(
                        children: [
                          // Generate chip tiles for titles
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('BMW'),
                                selected: selectedTitle == 'BMW',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedTitle = isSelected ? 'BMW' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedTitle == 'BMW'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedTitle == 'BMW'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('Honda'),
                                selected: selectedTitle == 'Honda',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedTitle = isSelected ? 'Honda' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedTitle == 'Honda'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedTitle == 'Honda'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('Tesla'),
                                selected: selectedTitle == 'Tesla',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedTitle = isSelected ? 'Tesla' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedTitle == 'Tesla'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedTitle == 'Tesla'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Select Model:',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Wrap(
                        children: [
                          // Generate chip tiles for titles
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('2018'),
                                selected: selectedSecondTitle == '2018',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedSecondTitle =
                                        isSelected ? '2018' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedSecondTitle == '2018'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedSecondTitle == '2018'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('2019'),
                                selected: selectedSecondTitle == '2019',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedSecondTitle =
                                        isSelected ? '2019' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedSecondTitle == '2019'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedSecondTitle == '2019'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .black, // Set permanent background color to black
                              borderRadius: BorderRadius.circular(
                                  10.0), // Adjust border radius as needed
                            ),
                            child: Theme(
                              data: ThemeData(
                                  // toggleableActiveColor: Colors
                                  //     .blue, // Set checkmark color to blue when selected
                                  ),
                              child: ChoiceChip(
                                label: Text('2020'),
                                selected: selectedSecondTitle == '2020',
                                onSelected: (isSelected) {
                                  setState(() {
                                    selectedSecondTitle =
                                        isSelected ? '2020' : '';
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                    color: selectedSecondTitle == '2020'
                                        ? Colors.blueAccent
                                        : Colors
                                            .white, // Set border color to white when not selected and blue when selected
                                    width: selectedSecondTitle == '2020'
                                        ? 1.5
                                        : 0.0, // Set border width to 2.0 when selected
                                  ),
                                ),
                                backgroundColor: Colors
                                    .black, // Set permanent background color to black
                                selectedColor:
                                    Colors.black, // Set selected color to black
                                labelStyle: TextStyle(
                                    color: Colors
                                        .white), // Set label color to white

                                showCheckmark:
                                    false, // Hide the default checkmark
                                //selectedShadowColor: Colors
                                //.transparent, // Remove shadow when selected
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (selectedTitle != '' &&
                                  selectedSecondTitle != '') {
                                Navigator.pop(context);
                                Provider.of<chDataProvider>(context,
                                        listen: false)
                                    .defaultBrand = selectedTitle!;
                                Provider.of<chDataProvider>(context,
                                        listen: false)
                                    .defaultModel = selectedSecondTitle!;
                                String Email = Provider.of<chDataProvider>(
                                        context,
                                        listen: false)
                                    .userEmail!;
                                addUserDefaults(Email, selectedTitle!,
                                    selectedSecondTitle!);
                                print(selectedSecondTitle);
                                print(selectedTitle);
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text:
                                      "Please choose your Default Electric Vehicle",
                                );
                              }
                              // Update loading2 within the Future
                              // fetchData();

                              // waiting for 2 seconds
                              // await Future.delayed(const Duration(seconds: 2));
                              // again making loading to true to show the output
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.black, // Set font color to white
                              side: BorderSide(
                                  color: Colors.blue,
                                  width: 2), // Add blue border
                              padding: EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 24), // Increase padding for size
                              textStyle:
                                  TextStyle(fontSize: 20), // Increase font size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Set border radius
                              ),
                            ),
                            child: Text('Apply'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  Future<void> addUserDefaults(
      String userEmail, String defaultBrand, String defaultModel) async {
    // Get a reference to the Firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      // Query for the document with the specified email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: userEmail).get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document per email, get the reference to that document
        DocumentReference userDocRef = querySnapshot.docs.first.reference;

        // Update the document with defaultBrand and defaultModel fields
        await userDocRef.update({
          'defaultBrand': defaultBrand,
          'defaultModel': defaultModel,
        });

        print('User defaults added successfully.');
      } else {
        print('No user found with the specified email.');
      }
    } catch (e) {
      print('Error adding user defaults: $e');
    }
  }

  Future<void> Help(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue, width: 0.8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: Text(
            'Help',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            // Wrap content with SingleChildScrollView
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to EV Nav Help Center\n',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '1. Getting Started\n'
                  '   - Navigation Basics:\n'
                  '     - Use the map to explore your surroundings.\n'
                  '     - Pinch to zoom in and out for a closer or broader view.\n'
                  '     - Drag the map to move around.\n\n'
                  '   - Searching for Destinations:\n'
                  '     - Tap on the search bar to enter your destination.\n'
                  '     - You can search for addresses, landmarks, or points of interest.\n'
                  '     - Select your destination from the search results to set it as your route.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '2. Using Filters for Charging Stations\n'
                  '   - Battery Percentage Filter:\n'
                  '     - Set your battery percentage to find charging stations within your range.\n\n'
                  '   - Charging Type Filter:\n'
                  '     - Choose between fast or normal charging options.\n'
                  '     - Fast charging stations provide quicker charge times but a little high cost.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '3. Booking a Charging Slot\n'
                  '   - Find a Charging Station:\n'
                  '     - Use the map or search function to locate nearby charging stations.\n'
                  '     - Apply filters to narrow down the search based on your preferences.\n\n'
                  '   - Reserve a Slot:\n'
                  '     - Select a charging station and check availability.\n'
                  '     - Book your slot in advance to ensure a charging spot upon arrival.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '4. Additional Support\n'
                  '   - FAQs:\n'
                  '     - Find answers to commonly asked questions about the app and its features.\n\n'
                  '   - Contact Us:\n'
                  '     - Reach out to our support team for assistance or feedback.\n'
                  '     - We\'re here to help you make the most of your EV Nav experience.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '5. Legal\n'
                  '   - Terms of Service:\n'
                  '     - Review our terms and conditions for using the EV Nav app.\n\n'
                  '   - Privacy Policy:\n'
                  '     - Learn how we collect, use, and protect your personal information.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '6. About EV Nav\n'
                  '   - About Us:\n'
                  '     - Discover more about the team behind the EV Nav app.\n'
                  '     - Learn about our mission and commitment to sustainable transportation.\n\n',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'OK',
                style:
                    TextStyle(color: Colors.blue), // Set the text color to blue
              ),
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
