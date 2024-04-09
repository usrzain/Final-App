import 'package:flutter/material.dart';

class FavoriteStationsProvider extends ChangeNotifier {
  final List<String> _stations = [];
  final Map<String, String> _stationKeys =
      {}; // Map stores key-value pairs (key: station name, value: unique key)

  void addStation(String station, String key) {
    _stations.add(station);
    _stationKeys[station] = key;
    notifyListeners();
  }

  void removeStation(String station) {
    final key = _stationKeys.remove(station);
    if (key != null) {
      _stations.removeWhere(
          (s) => _stationKeys[s] == key); // Remove station based on key
    }
    notifyListeners();
  }

  List<String> get stations => _stations; // Return the list of stations

  String _generateUniqueKey() {
    // Implement logic to generate a unique key (e.g., using a counter)
    int counter = 0;
    return 'key-${counter++}'; // Simple counter-based key generation
  }
}
