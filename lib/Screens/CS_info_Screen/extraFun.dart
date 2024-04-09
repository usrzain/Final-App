import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getCustomIcon(String assetPath) async {
  final BitmapDescriptor bitmapDescriptor =
      await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio: 2.0),
    assetPath,
  );
  return bitmapDescriptor;
}

Widget loadingWidget(BuildContext context, String text) {
  return Stack(
    children: [
      Container(
          alignment: Alignment.center, child: CircularProgressIndicator()),
      Container(alignment: Alignment.center, child: Text('$text is loading '))
    ],
  );
}

class favChargingStation {
  String? name;
  String? address;
  String? chargeType;

  favChargingStation(this.name, this.chargeType, this.address);

  // Convert to JSON string
  Map<String, dynamic> toJson() =>
      {'name': name, 'chargeType': chargeType, 'address': address};

  // Factory constructor to create from JSON
  factory favChargingStation.fromJson(Map<String, dynamic> json) =>
      favChargingStation(json['name'], json['chargeType'], json['address']);
}
