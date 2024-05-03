import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<BitmapDescriptor> getCustomIcon(String assetPath) async {
  final BitmapDescriptor bitmapDescriptor =
      await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(devicePixelRatio: 2.0),
    assetPath,
  );
  return bitmapDescriptor;
}

class LoadingWidget extends StatefulWidget {
  final String text; // Optional text to display with the animation
  final double size; // Size of the animation (default: 100)

  const LoadingWidget(
      {Key? key, this.text = 'Fetching Best CS', this.size = 40})
      : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: false); // Continuously repeat without reversal
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.text == 'Fetching Best CS'
            ? Colors.white.withOpacity(0.5)
            : Colors.black,
        child: Center(
          child: Column(
            // Use Row for horizontal arrangement
            mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
            children: [
              widget.text == 'Map' // Check if text is empty (icon-only mode)
                  ? Column(
                      children: [
                        Icon(
                          Icons.map_sharp,
                          size: 100,
                          color: Colors.blue,
                        ),
                      ],
                    ) // Display icon
                  : Icon(
                      Icons.route_outlined,
                      size: 100,
                      color: Colors.blue,
                    ),

              const SizedBox(width: 50.0), // Add horizontal spacing

              // Loading animation
              LoadingAnimationWidget.discreteCircle(
                  color: Colors.blue,
                  size: widget.size,
                  secondRingColor: Colors.orange,
                  thirdRingColor: Colors.red),

              const SizedBox(width: 50.0),
              widget.text == 'Map'
                  ? Text(
                      'On the way...',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Fetching Best Charging Station....',
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    )
              // LoadingAnimationWidget.threeArchedCircle(
              //   color: Colors.blue,
              //   size: widget.size,
              // ),
            ],
          ),
        ));
  }
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
