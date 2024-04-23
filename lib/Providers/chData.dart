// lib/providers/your_data_provider.dart

import 'dart:html';
import 'dart:js';
import 'dart:math';

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
  final String name;
  final String address;
  final double cost;

  FavStationData(
      {required this.name, required this.address, required this.cost});
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
  int? _stateOfCharge = 2;
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
  Map<String, dynamic> _favStations = {};
  List<String> _favStationList = [];
  LocationData? _currentLocation;
  List<String> _currentLocationList = ['CL1', 'CL2', 'CL3'];
  double _totalCost = 0.0;
  double? _timeTaken = 0.0;
  double _perKWHCost = 0.0;
  double _totalDistance = 0.0;
  double _selectedLatitude = 0.0;
  double _selectedLongitude = 0.0;
  String _selectedStation = '';
  String _selectedKey = '';
  Map<String, dynamic> _bookings = {};
  bool _allowToBook = false;

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
  Map<String, dynamic> get favStations => _favStations;
  List<String> get favStationList => _favStationList.toList();
  List<String> get currentLocationList => _currentLocationList;
  double get totalCost => _totalCost;
  double? get timeTaken => _timeTaken;
  double get perKWHCost => _perKWHCost;
  double get totalDistance => _totalDistance;
  double get selectedLatitude => _selectedLatitude;
  double get selectedLongitude => _selectedLongitude;
  String get selectedStation => _selectedStation;
  String get selectedKey => _selectedKey;
  Map<String, dynamic> get bookings => _bookings;
  bool get allowToBook => _allowToBook;

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

  set totalCost(double value) {
    _totalCost = value;
    notifyListeners();
  }

  set timeTaken(double? value) {
    _timeTaken = value;
    notifyListeners();
  }

  set perKWHCost(double value) {
    _perKWHCost = value;
    notifyListeners();
  }

  set totalDistance(double value) {
    _totalDistance = value;
    notifyListeners();
  }

  set selectedLatitude(double value) {
    _selectedLatitude = value;
    notifyListeners();
  }

  set selectedLongitude(double value) {
    _selectedLongitude = value;
    notifyListeners();
  }

  set selectedStation(String value) {
    _selectedStation = value;
    notifyListeners();
  }

  set selectedKey(dynamic value) {
    _selectedKey = value;
    notifyListeners();
  }

  set allowToBook(bool value) {
    _allowToBook = value;
    notifyListeners();
  }

  double getKwhForOnePercent() {
    switch (vehBrand) {
      case 'Tesla':
        return 0.12;
      case 'BMW':
        return 0.10;
      case 'Honda':
        return 0.8;
      default:
        return -1.0; // Indicate an unknown vehicle type
    }
  }

  double arrivalBattery() {
    double teslaKwhPerKm = 0.2;
    double bmwKwhPerKm = 0.24;
    double hondaKwhPerKm = 0.3;
    double vehKwhPerKm = 0.0;
    switch (vehBrand) {
      case 'Tesla':
        vehKwhPerKm = teslaKwhPerKm;
      case 'BMW':
        vehKwhPerKm = bmwKwhPerKm;
      case 'Honda':
        vehKwhPerKm = hondaKwhPerKm;
      default:
        vehKwhPerKm = 0.0; // Indicate an unknown vehicle type
    }

    double totalKwhOverTotalDistance = vehKwhPerKm * totalDistance;
    double kwhperpercent = getKwhForOnePercent();
    double totalKwhUsable = kwhperpercent * stateOfCharge!.toDouble();
    double totalKWhAfterJourney = totalKwhUsable - totalKwhOverTotalDistance;
    double arrivalBattery = totalKWhAfterJourney / kwhperpercent;

    print(arrivalBattery);

    return arrivalBattery;
  }

  String generateRandomNumber() {
    final random = Random();
    // Generate a random integer between 100000 and 999999 (inclusive)
    var randomNumber = random.nextInt(999999) + 100000;
    // Convert the integer to a string
    return randomNumber.toString();
  }

  MapEntry<String, dynamic>? findEntryByTitle(
    String title,
  ) {
    // Use where to filter entries where the title is "gkf"
    return chargingStations.entries
        .where((entry) => entry.value?['title'] == title)
        .firstOrNull;
  }

  bool findEitherFavExistsOrNot(
    String title,
  ) {
    // Use where to filter entries where the title is "gkf"
    MapEntry<String, dynamic>? result = favStations.entries
        .where((entry) => entry.value?['title'] == title)
        .firstOrNull;
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  bool addBookings(String stationTitle, String token, time, cost) {
    try {
      final entry = findEntryByTitle(stationTitle);
      Map<String, dynamic> newData = {
        entry!.key: {
          'Booked on': DateTime.now(),
          'title': entry.value['title'],
          'address': entry.value['address'],
          'total cost': cost,
          'token': token,
          'time': time
        }
      };
      bookings.addAll(newData);
      return true;
    } catch (error) {
      return false;
    }
  }

  bool addFavoriteStation(String stationTitle) {
    // Find the entry with title "gkf"
    bool found = findEitherFavExistsOrNot(stationTitle);
    if (found) {
      print('already here');
      print(favStations);
      return false;
    } else {
      final entry = findEntryByTitle(stationTitle);
      Map<String, dynamic> newData = {
        entry!.key: {
          'title': entry.value['title'],
          'address': entry.value['address'],
          'cost': entry.value['cost']
        }
      };
      favStations.addAll(newData);
      print('adding new data ');
      print(favStations);
      return true;
    }
  }
}
