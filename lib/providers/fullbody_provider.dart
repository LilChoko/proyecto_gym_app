import 'package:flutter/material.dart';

class FullBodyProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Cuerpo Completo)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Press militar', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {'name': 'Crunches', 'series': 'Series: 4', 'reps': 'Reps: 20'},
    ],
    'Miércoles (Cuerpo Completo)': [
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 3', 'reps': 'Reps: 6'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Fondos para tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones de piernas',
        'series': 'Series: 4',
        'reps': 'Reps: 20'
      },
    ],
    // Más días...
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;

  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
