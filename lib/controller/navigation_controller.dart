import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  int currentScreen = 0;

  void onTap(int screen) {
    currentScreen = screen;
    notifyListeners();
  }
}