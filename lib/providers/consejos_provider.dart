import 'package:flutter/material.dart';

class ConsejosProvider with ChangeNotifier {
  final List<Map<String, String>> _consejos = [
    {
      'title': 'Consejo 1: Repeticiones y series',
      'content':
          'Recuerda que una repetición es una sola ejecución completa de un ejercicio mientras que una serie es un conjunto de repeticiones realizadas consecutivamente sin descanso.',
      'lottie': 'assets/lotties/tip1.json',
    },
    {
      'title': 'Consejo 2: Hidratación',
      'content':
          'Mantente hidratado durante tus entrenamientos. Beber agua ayuda a mejorar tu rendimiento y a prevenir calambres.',
      'lottie': 'assets/lotties/tip2.json',
    },
    {
      'title': 'Consejo 3: Técnica correcta',
      'content':
          'Prioriza la técnica sobre el peso para evitar lesiones y obtener mejores resultados en tus ejercicios.',
      'lottie': 'assets/lotties/tip3.json',
    },
    {
      'title': 'Consejo 4: Descanso',
      'content':
          'El descanso es crucial para la recuperación muscular. Asegúrate de dormir lo suficiente y dar tiempo a tus músculos para recuperarse.',
      'lottie': 'assets/lotties/tip4.json',
    },
    {
      'title': 'Consejo 5: Alimentación',
      'content':
          'Lleva una alimentación balanceada que incluya proteínas, carbohidratos y grasas saludables para optimizar tus entrenamientos.',
      'lottie': 'assets/lotties/tip5.json',
    },
  ];

  int? _expandedIndex;

  // Getters
  List<Map<String, String>> get consejos => _consejos;
  int? get expandedIndex => _expandedIndex;

  // Métodos
  void toggleExpansion(int index) {
    if (_expandedIndex == index) {
      _expandedIndex = null;
    } else {
      _expandedIndex = index;
    }
    notifyListeners();
  }
}
