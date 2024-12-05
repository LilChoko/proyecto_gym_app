import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CuestionarioProvider with ChangeNotifier {
  int _selectedOption = -1; // Opción seleccionada en Cuestionario 1
  int _currentIndex = 0; // Página actual
  String? _name;
  String? _height;
  String? _weight;
  String? _gender;

  // Getters
  int get selectedOption => _selectedOption;
  int get currentIndex => _currentIndex;
  String? get name => _name;
  String? get height => _height;
  String? get weight => _weight;
  String? get gender => _gender;

  // Métodos para actualizar el estado
  void selectOption(int index) {
    _selectedOption = index;
    notifyListeners();
  }

  void nextPage() {
    _currentIndex = (_currentIndex + 1).clamp(0, 2);
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void setHeight(String value) {
    _height = value;
    notifyListeners();
  }

  void setWeight(String value) {
    _weight = value;
    notifyListeners();
  }

  void setGender(String? value) {
    _gender = value;
    notifyListeners();
  }

  // Guardar datos en SharedPreferences
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('completedQuestionnaire', true);
    await prefs.setString('name', _name ?? '');
    await prefs.setString('height', _height ?? '');
    await prefs.setString('weight', _weight ?? '');
    await prefs.setString('gender', _gender ?? '');
  }
}
