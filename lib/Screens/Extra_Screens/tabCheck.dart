// import 'package:flutter/material.dart';

// class TabCheck extends StatelessWidget {
//   List<Tab> tabs = [
//     Tab(
//       icon: Icon(Icons.color_lens),
//       text: "Teal",
//     ),
//     Tab(
//       icon: Icon(Icons.local_florist),
//       text: "Green",
//     ),
//     Tab(
//       icon: Icon(Icons.palette),
//       text: "Blue",
//     ),
//     Tab(
//       icon: Icon(Icons.star),
//       text: "Yellow",
//     ),
//     Tab(
//       icon: Icon(Icons.whatshot),
//       text: "Red",
//     ),
//     Tab(
//       icon: Icon(Icons.local_car_wash),
//       text: "Orange",
//     ),
//     Tab(
//       icon: Icon(Icons.settings),
//       text: "Grey",
//     ),
//   ];

//   List<Widget> tabsContent = [
//     Container(color: Colors.teal),
//     Container(color: Colors.green),
//     Container(color: Colors.blue),
//     Container(color: Colors.yellow),
//     Container(color: Colors.red),
//     Container(color: Colors.orange),
//     Container(color: Colors.grey),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return DefaultTabController(
//       length: tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Scrollable Tab"),
//           backgroundColor: Colors.green[700],
//           centerTitle: true,
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(80),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//               child: TabBar(
//                 indicatorColor: Colors.white,
//                 isScrollable: true,
//                 tabs: tabs,
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: tabsContent,
//         ),
//       ),
//     );
//   }
// }


