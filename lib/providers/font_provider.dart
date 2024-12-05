import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontProvider with ChangeNotifier {
  String _selectedFont = 'Roboto';

  String get selectedFont => _selectedFont;

  Future<void> loadFontPreference() async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFont = prefs.getString('selectedFont') ?? 'Roboto';
    notifyListeners();
  }

  Future<void> saveFontPreference(String font) async {
    final prefs = await SharedPreferences.getInstance();
    _selectedFont = font;
    await prefs.setString('selectedFont', font);
    notifyListeners();
  }
}
