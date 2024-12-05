import 'package:flutter/material.dart';

class HeavyProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Pecho y Espalda)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {'name': 'Press inclinado', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
    ],
    'Miércoles (Piernas y Abdomen)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Crunches', 'series': 'Series: 4', 'reps': 'Reps: 20'},
      {'name': 'Plancha', 'series': 'Series: 3', 'reps': 'Duración: 60 seg'},
    ],
    'Viernes (Hombros y Brazos)': [
      {'name': 'Press militar', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {'name': 'Curl de bíceps', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Extensiones de tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
    ],
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;
  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
