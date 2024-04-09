import 'package:flutter/foundation.dart';

class loading extends ChangeNotifier {
  int value = 1; // Initial value

  void setValue(int newValue) {
    value = newValue;
    notifyListeners(); // Notify listeners about the change
  }
}
