import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> saveThemePreference(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await prefs.setBool('isDarkTheme', isDark);
    notifyListeners();
  }

  void toggleTheme() {
    saveThemePreference(_themeMode == ThemeMode.light);
  }
}
