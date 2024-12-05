import 'package:flutter/material.dart';

class ArnoldProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Pecho y Espalda)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Aperturas con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {'name': 'Peso muerto', 'series': 'Series: 3', 'reps': 'Reps: 10'},
    ],
    'Martes (Hombros y Brazos)': [
      {'name': 'Press militar', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones frontales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Fondos para tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
    // Agrega el resto de los días y ejercicios aquí
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;

  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
