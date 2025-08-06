import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  DarkThemeProvider() {
    _loadDarkMode();
  }

  void _loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void toggleDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }
}