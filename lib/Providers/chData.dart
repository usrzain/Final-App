// lib/providers/your_data_provider.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Charging Station class

class ChargingStation {
  final String id;
  final int availableSlots;
  final double cost;
  final double distance;
  final List<double> location;
  final int queue;
  final String duration;
  final String address;
  final String chrgType;
  final String title;
  final bool fav;

  ChargingStation(
      {required this.id,
      required this.availableSlots,
      required this.cost,
      required this.distance,
      required this.location,
      required this.queue,
      required this.duration,
      required this.address,
      required this.chrgType,
      required this.title,
      this.fav = false});

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
        id: json['id'],
        availableSlots: json['available_slots'],
        cost: json['cost'],
        distance: json['distance'],
        location: List<double>.from(json['location']),
        queue: json['queue'],
        duration: json['duration'],
        address: json['address'],
        chrgType: json['chrgType'],
        title: json['title'],
        fav: json['fav']);
  }
}

// Charging Station class

// Fav Station Class
class FavStationData {
  final String key;
  final String value;

  FavStationData({required this.key, required this.value});
}

String _generateUniqueKey() {
  // Implement logic to generate a unique key (e.g., using a counter)
  int counter = 0;
  return 'key-${counter++}'; // Simple counter-based key generation
}

// Fav Station Class

class chDataProvider extends ChangeNotifier {
  // Data variable to store the fetched data
  bool _loading = false;
  bool _loading2 =
      false; // this is for the rebuilding of Map and First building of Map
  bool _markerLoadingComplete = false;
  LatLng _initialPosition = LatLng(0.0, 0.0);
  Map<String, dynamic> _chargingStations = {};
  bool _polyLineDone = false;
  Set<Marker> _markers = {};
  Set<Polyline> _pPoints = {};
  int? _stateOfCharge;
  String? _vehBrand;
  String? _vehModel;
  bool _showReset = true;
  double _range = 0;
  bool _hasSeenTheIntro = false;
  bool _initialLoadingComplete = false;
  String? _userEmail;
  Map<String, dynamic>? _userData = {};
  bool _signInComplete = false;
  bool _signInProgress = false;
  String? _userName;
  User? _loggedInUser;
  bool _profileFetchingDone = false;
  List<String> _favStationList = [];
  LocationData? _currentLocation;
  List<String> _currentLocationList = ['CL1', 'CL2', 'CL3'];

  // Getter to access the data
  bool get loading => _loading;
  bool get loading2 => _loading2;
  LatLng get initialPosition => _initialPosition;
  Map<String, dynamic> get chargingStations => _chargingStations;
  bool get markerLoadingComplete => _markerLoadingComplete;
  bool get polyLineDone => _polyLineDone;
  Set<Marker> get markers => _markers;
  Set<Polyline> get pPoints => _pPoints;
  int? get stateOfCharge => _stateOfCharge;
  String? get vehBrand => _vehBrand;
  String? get vehModel => _vehModel;
  bool get showReset => _showReset;
  double get range => _range;
  bool get hasSeenTheIntro => _hasSeenTheIntro;
  bool get initialLoadingComplete => _initialLoadingComplete;
  String? get userEmail => _userEmail;
  Map<String, dynamic>? get userData => _userData;
  bool get signInComplete => _signInComplete;
  bool get signInProgress => _signInComplete;
  String? get userName => _userName;
  User? get loggedInUser => _loggedInUser;
  LocationData? get currentLocation => _currentLocation;
  bool get profileFetchingDone => _profileFetchingDone;
  List<String> get favStationList => _favStationList.toList();
  List<String> get currentLocationList => _currentLocationList;

  int value = 1; // Initial value

  void setValue(int newValue) {
    value = newValue;
    notifyListeners(); // Notify listeners about the change
  }

  set initialPosition(LatLng value) {
    _initialPosition = value;
    notifyListeners();
  }

  set loggedInUser(User? value) {
    _loggedInUser = value;
    notifyListeners(); // Notify listeners about the change
  }

  // Setter to update the data and notify listeners
  set loading(bool value) {
    _loading = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set loading2(bool value) {
    _loading2 = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set markerLoadingComplete(bool value) {
    _markerLoadingComplete = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  inverse() {
    _loading2 = !_loading2;
  }

  set chargingStations(Map<String, dynamic> value) {
    _chargingStations = value;
    notifyListeners();
  }

  set polyLineDone(bool value) {
    _polyLineDone = value;
    notifyListeners();
  }

  set markers(Set<Marker> value) {
    _markers = value;
    notifyListeners();
  }

  set pPoints(Set<Polyline> value) {
    _pPoints = value;
    notifyListeners();
  }

  set stateOfCharge(int? value) {
    _stateOfCharge = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set vehModel(String? value) {
    _vehModel = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set vehBrand(String? value) {
    _vehBrand = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set showReset(bool value) {
    _showReset = value;
    notifyListeners(); // Notify listeners that data has changed
  }

  set range(double value) {
    _range = value;
    notifyListeners();
  }

  set hasSeenTheIntro(bool value) {
    _hasSeenTheIntro = value;
    notifyListeners();
  }

  set initialLoadingComplete(bool value) {
    _initialLoadingComplete = value;
    notifyListeners();
  }

  set userEmail(String? value) {
    _userEmail = value;
    notifyListeners();
  }

  set userName(String? value) {
    _userName = value;
    notifyListeners();
  }

  set signInComplete(bool value) {
    _signInComplete = value;
    notifyListeners();
  }

  set signInProgress(bool value) {
    _signInProgress = value;
    notifyListeners();
  }

  set currentLocation(LocationData? value) {
    _currentLocation = value;
    notifyListeners();
  }

  set profileFetchingDone(bool value) {
    _profileFetchingDone = value;
    notifyListeners();
  }

  void addFavoriteStation(String stationId) {
    if (!_favStationList.contains(stationId)) {
      _favStationList.add(stationId);
      notifyListeners();
    }
  }

  bool isFavorite(String stationId) => _favStationList.contains(stationId);
}
