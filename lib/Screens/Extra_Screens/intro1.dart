// // import 'package:flutter/material.dart';

// // class Intro1 extends StatefulWidget {
// //   const Intro1({Key? key}) : super(key: key);

// //   @override
// //   _Intro1State createState() => _Intro1State();
// // }

// // class _Intro1State extends State<Intro1> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(''),
// //       ),
// //       body: Container(),
// //     );
// //   }
// // }
// import 'package:animate_do/animate_do.dart';
// //import 'package:app_intro_day21/helpers/ColorsSys.dart';
// //import 'package:app_intro_day21/helpers/Strings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// // void main() {
// //   runApp(MaterialApp(
// //     debugShowCheckedModeBanner: false,
// //     home: HomePage(),
// //   ));
// // }

// // screens.dart

// import 'package:flutter/material.dart';

// class Intro1 extends StatefulWidget {
//   @override
//   _Intro1State createState() => _Intro1State();
// }

// class _Intro1State extends State<Intro1> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (page) {
//           setState(() {
//             _currentPage = page;
//           });
//         },
//         children: [
//           buildScreen("Screen 1", "assets/Intro/evbk.png"),
//           buildScreen("Screen 2", "assets/image2.png"),
//           buildScreen("Screen 3", "assets/image3.png"),
//         ],
//       ),
//     );
//   }

//   Widget buildScreen(String title, String imagePath) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24.0,
//           ),
//         ),
//         SizedBox(height: 20.0),
//         Container(
//           width: double.infinity, // Make the container span the entire width
//           child: Image.asset(
//             imagePath,
//             fit: BoxFit.cover, // Ensure the image covers the entire container
//             height: 200.0, // Set the desired height
//           ),
//         ),
//         SizedBox(height: 20.0),
//         ElevatedButton(
//           onPressed: () {
//             if (_currentPage < 2) {
//               _pageController.animateToPage(
//                 _currentPage + 1,
//                 duration: Duration(milliseconds: 500),
//                 curve: Curves.easeInOut,
//               );
//             } else {
//               // Handle the action when the last screen is reached
//               // You can navigate to the next screen or perform any other action
//             }
//           },
//           child: Text("Skip", style: TextStyle(color: Colors.white)),
//           style: ElevatedButton.styleFrom(
//             primary: Colors.blue,
//           ),
//         ),
//       ],
//     );
//   }
// }
