// import 'package:flutter/material.dart';
    
// class FinalTabView extends StatelessWidget {

//   //const FinalTabView({ Key? key }) : super(key: key);
  
//   List<Tab> tabs = [
//     Tab(
//       icon: Icon(Icons.color_lens),
//       child: Text("Teal"),
//     ),
//     Tab(
//       icon: Icon(Icons.local_florist),
//       child: Text("Green"),
//     ),
//     Tab(
//       icon: Icon(Icons.palette),
//       child: Text("Blue"),
//     ),
//     Tab(
//       icon: Icon(Icons.star),
//       child: Text("Yellow"),
//     ),
//     Tab(
//       icon: Icon(Icons.whatshot),
//       child: Text("Red"),
//     ),
//     Tab(
//       icon: Icon(Icons.local_car_wash),
//       child: Text("Orange"),
//     ),
//     Tab(
//       icon: Icon(Icons.settings),
//       child: Text("Grey"),
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
//     return DefaultTabController(
//       length: tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Scrollable Tab"),
//           backgroundColor: Colors.green[700],
//           centerTitle: true,
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(50),
//             child: Align(
//               alignment: Alignment.bottomCenter,
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