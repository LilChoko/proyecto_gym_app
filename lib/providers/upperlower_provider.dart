import 'package:flutter/material.dart';

class UpperLowerProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Parte Superior)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Press militar', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Curl de bíceps con barra',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
    ],
    'Martes (Parte Inferior)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto rumano', 'series': 'Series: 3', 'reps': 'Reps: 8'},
      {'name': 'Prensa de piernas', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {'name': 'Curl de piernas', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones de talones',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {'name': 'Abdominales', 'series': '', 'reps': '(Crunches, Plancha)'},
    ],
    'Jueves (Parte Superior)': [
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Remo con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Fondos en paralelas',
        'series': 'Series: 3',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Curl de bíceps con mancuernas',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Extension en agarre V',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
    ],
    'Viernes (Parte Inferior)': [
      {
        'name': 'Sentadillas frontales',
        'series': 'Series: 4',
        'reps': 'Reps: 10'
      },
      {
        'name': 'Peso muerto convencional',
        'series': 'Series: 4',
        'reps': 'Reps: 6'
      },
      {'name': 'Zancadas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
      {
        'name': 'Elevaciones de talones sentado',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {'name': 'Planchas', 'series': 'Series: 3', 'reps': 'Reps: 60 segundos'},
      {
        'name': 'Elevaciones de piernas',
        'series': 'Series: 4',
        'reps': 'Reps: 20'
      },
    ],
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;
  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
