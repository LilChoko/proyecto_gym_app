import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CuestionarioProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Guardar datos en Firestore
  Future<void> saveData(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'name': _name,
        'height': _height,
        'weight': _weight,
        'gender': _gender,
        'completed_questionnaire': true,
      });
    } catch (e) {
      throw Exception('Error al guardar los datos del cuestionario: $e');
    }
  }
}
