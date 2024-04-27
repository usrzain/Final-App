// children: [
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.location_on,
//                                           color: Colors.red), // Location icon
//                                       const SizedBox(width: 4),
//                                       Flexible(
//                                         child: Text(
//                                           dataProvider.bookings.entries
//                                               .elementAt(index)
//                                               .value['address'],
//                                           style: const TextStyle(
//                                             fontStyle: FontStyle.italic,
//                                             color: Colors.white,
//                                             fontSize: 18,
//                                             // White text color
//                                           ),
//                                           maxLines: 2,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.attach_money,
//                                           color: Colors.green), // Cost icon
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         'Booked on: ${dataProvider.bookings.entries.elementAt(index).value['Booked on'].toString()}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.attach_money,
//                                           color: Colors.green), // Cost icon
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         'Reach until: ${dataProvider.bookings.entries.elementAt(index).value['time'].toString()}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.attach_money,
//                                           color: Colors.green), // Cost icon
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         'Token No: ${dataProvider.bookings.entries.elementAt(index).value['token'].toString()}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       const Icon(Icons.attach_money,
//                                           color: Colors.green), // Cost icon
//                                       const SizedBox(width: 4),
//                                       Text(
//                                         'total cost: \$${dataProvider.bookings.entries.elementAt(index).value['total cost'].toStringAsFixed(2)}',
//                                         style: const TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],