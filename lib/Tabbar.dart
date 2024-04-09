// import 'package:effecient/Auth/loginPage.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class WelcomePage extends StatefulWidget {
//   final User? user;

//   const WelcomePage({Key? key, required this.user}) : super(key: key);

//   @override
//   _WelcomePageState createState() => _WelcomePageState();
// }

// class _WelcomePageState extends State<WelcomePage> {
//   String _greetingMessage = '';
//   String _userId = ''; // Stores the user ID

//   @override
//   void initState() {
//     super.initState();
//     _fetchGreetingMessage();
//     _userId = widget.user?.uid ?? '';
//     // Initialize TabController// Retrieve user ID from the widget
//     print(_userId);
//   }

//   Future<void> _fetchGreetingMessage() async {
//     // Replace with your personalized greeting logic
//     String greeting = "Welcome back, $_userId!";
//     setState(() {
//       _greetingMessage = greeting;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Welcome'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.person), // Use a suitable icon
//             onPressed: () {
//               // Show user details widget (replace with your implementation)
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) => Text("User Details:\nID: $_userId"),
//               );
//             },
//           ),
//           logoutButton(context),
//         ],
//       ),
//       body: 
//     );
//   }

  // ElevatedButton logoutButton(BuildContext context) {
  //   return ElevatedButton(
  //     onPressed: () async {
  //       await FirebaseAuth.instance.signOut();
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const LoginPage()),
  //       );
  //     },
  //     child: const Text('Logout'),
  //   );
  // }
// }
