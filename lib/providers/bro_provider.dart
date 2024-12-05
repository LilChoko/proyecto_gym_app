import 'package:flutter/material.dart';

class BroProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Pecho)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Aperturas con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Fondos en paralelas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
    'Martes (Espalda)': [
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 3', 'reps': 'Reps: 6'},
      {
        'name': 'Remo con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
    'Miércoles (Piernas)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Prensa de piernas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {'name': 'Curl de piernas', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones de talones',
        'series': 'Series: 4',
        'reps': 'Reps: 15'
      },
    ],
    'Jueves (Hombros)': [
      {'name': 'Press militar', 'series': 'Series: 4', 'reps': 'Reps: 10'},
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
        'name': 'Elevaciones posteriores',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
    ],
    'Viernes (Brazos)': [
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {
        'name': 'Fondos para tríceps',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
    ],
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;

  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
