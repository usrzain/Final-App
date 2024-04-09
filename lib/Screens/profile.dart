// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   final User? user;

//   const Profile({Key? key, required this.user}) : super(key: key);

//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   // late String userEmail;
//   // extraction for the username from Firestore is remaining

//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   @override
//   void initState() {
//     super.initState();

//     // getUsernameByEmail('email');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }

//   Future<String?> getUsernameByEmail(String email) async {
//     try {
//       // Query Firestore to find the document with the matching email
//       QuerySnapshot<Map<String, dynamic>> querySnapshot =
//           await FirebaseFirestore.instance
//               .collection('users') // Replace 'users' with your collection name
//               .where('email', isEqualTo: email)
//               .limit(
//                   1) // Limit the query to 1 document (assuming email is unique)
//               .get();

//       // Check if any documents were found
//       if (querySnapshot.docs.isNotEmpty) {
//         // Extract the username from the document
//         return querySnapshot.docs.first.get('username');
//       } else {
//         // No document found with the provided email
//         return null;
//       }
//     } catch (e) {
//       // Handle any errors that occur during the query
//       print('Error retrieving username: $e');
//       return null;
//     }
//   }
// }
