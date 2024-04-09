import 'package:effecient/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const API_KEY =
    "AIzaSyBeG5g3Ps44SleGRirPm4IcnC9BvwbLqDI"; // Replace with your Google Maps API key

class GetRoute extends StatefulWidget {
  late LatLng origin;
  late LatLng destination;

  GetRoute();

  @override
  _GetRouteState createState() => _GetRouteState();
}

class _GetRouteState extends State<GetRoute> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  String distance = "";

  Future<void> getRouteDirections() async {
    final directionsUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${widget.origin.latitude},${widget.origin.longitude}&destination=${widget.destination.latitude},${widget.destination.longitude}&key=$API_KEY";

    List<LatLng> OriginDstList = [widget.origin, widget.destination];

    final response = await http.get(Uri.parse(directionsUrl));
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      setState(() {
        distance = data['routes'][0]['legs'][0]['distance']['text'];
      });

      final points = data['routes'][0]['overview_polyline']['points'];
      print('data-------------');
      print(data['routes']);
      print('---------------');

      final decodedPolyline = PolylinePoints().decodePolyline(points);
    } else {
      print("Error fetching directions: ${data['error_message']}");
    }
  }

  @override
  void initState() {
    getRouteDirections();
    //
    createMarkers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Distance: $distance"),
        Expanded(
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.origin,
              zoom: 12,
            ),
            markers: _markers,
            // polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (controller) => mapController = controller,
          ),
        ),
      ],
    );
  }

  Future<void> createMarkers() async {
    List<LatLng> OriginDstList = [widget.origin, widget.destination];
    for (int i = 0; i < OriginDstList.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: OriginDstList[i],
        infoWindow:
            InfoWindow(title: 'Really cool place!', snippet: '5 Star Rating'),
// InfoWindow
        icon: BitmapDescriptor.defaultMarker,
      ) // Marker
          );
      setState(() {});
    }
  }
}
