import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class ChargingStationAssignmentWidget extends StatefulWidget {
  @override
  _ChargingStationAssignmentState createState() =>
      _ChargingStationAssignmentState();
}

class _ChargingStationAssignmentState
    extends State<ChargingStationAssignmentWidget> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  Set<Polyline> polylinesSet = Set();

  @override
  Widget build(BuildContext context) {
    return ChargingStationAssignmentBody(_controller, markers, polylinesSet);
  }
}

class ChargingStationAssignmentBody extends StatelessWidget {
  final Completer<GoogleMapController> _controller;
  final Set<Marker> markers;
  final Set<Polyline> polylinesSet;

  ChargingStationAssignmentBody(
      this._controller, this.markers, this.polylinesSet);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charging Station Assignment'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers,
        polylines: polylinesSet,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0),
          zoom: 1,
        ),
      ),
    );
  }
}
