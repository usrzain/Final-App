// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:firebase_database/ui/firebase_animated_list.dart';
// // import 'package:flutter/material.dart';
// // import 'package:mapsandfirebase/AddandPostScreen.dart';
// // import 'package:mapsandfirebase/mapScreen.dart';

// import 'package:effecient/AddandPostScreen.dart';
// import 'package:effecient/GetRoute.dart';
// import 'package:effecient/Screens/CS_info_Screen/mapScreen.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Data extends StatefulWidget {
//   const Data({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _DataState createState() => _DataState();
// }

// class _DataState extends State<Data> {
//   // Create a Varibale for Loading

//   bool loading = false;
//   // Creating an empty List

//   // created a Table named as 'Locations'  in the Database
//   DatabaseReference ref = FirebaseDatabase.instance.ref("Locations");

//   // send data
//   // sendData(dynamic title) {
//   //   ref.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
//   //     'title': title,
//   //     'Latitude': 24.15,
//   //     'Longitude': 616.81,
//   //     'Availability': false,
//   //     'No of Slots available': 2,
//   //     'Distance': 'Distance ',
//   //     'Charging Speed ( KW )': 7
//   //   });
//   // }

//   @override
//   // void initState() {
//   //   super.initState();
//   // }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(' Sart'),
//       ),
//       floatingActionButton: FloatingActionButton(onPressed: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => AddandPostScreen()));
//       }),
//       body: Column(
//         children: [
//           IconButton(
//               icon: const Icon(Icons.map),
//               onPressed: () => {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const MapScreen()))
//                   }),
//           IconButton(
//               onPressed: () => {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => GetRoute(
//                                 // origin: LatLng(24.8458817,
//                                 //     67.0053605), // Replace with actual coordinates
//                                 // destination: LatLng(24.889279, 67.0495746)

//                                 )))
//                   },
//               icon: const Icon(Icons.access_time_sharp)),
//           Expanded(
//               child: FirebaseAnimatedList(
//                   query: ref,
//                   defaultChild: Text(' Loading....'),
//                   itemBuilder: (context, snapshot, animation, index) {
//                     return Column(
//                       // Use a Column for vertical layout
//                       children: [
//                         Text(snapshot
//                             .child('title')
//                             .value
//                             .toString()), // Display the title
//                         Text(snapshot
//                             .child('Latitude')
//                             .value
//                             .toString()), // Display field1
//                         Text(snapshot.child('Longitude').value.toString()),
//                         Text(snapshot.child('Availability').value.toString()),
//                         Text(snapshot
//                             .child('No of Slots available')
//                             .value
//                             .toString()),
//                         Text('DISTACE' +
//                             snapshot.child('Distance').value.toString()),
//                         Text(snapshot.child('cost').value.toString()),
//                         Text(snapshot
//                             .child('Charging Speed ( KW )')
//                             .value
//                             .toString()), // Display field2
//                         // Add more Text widgets for other fields you want to display
//                       ],
//                     );
//                   })),
//         ],
//       ),
//     );
//   }
// }
