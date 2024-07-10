import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeNotifier = ChangeNotifierProvider(
  (ref) => ThemeController(),
);

class ThemeController with ChangeNotifier {
  bool isChanged = false;
  void onChanged(bool value) {
    isChanged = value;
    notifyListeners();
  }
}
