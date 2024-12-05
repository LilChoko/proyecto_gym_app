import 'package:flutter/material.dart';

class PPLProvider with ChangeNotifier {
  final Map<String, List<Map<String, String>>> _workoutDays = {
    'Lunes (Push - Empuje)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {'name': 'Press militar', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {'name': 'Fondos en paralelas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
    ],
    'Martes (Pull - Tracción)': [
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 4', 'reps': 'Reps: 6'},
      {
        'name': 'Remo con mancuernas',
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
        'reps': 'Reps: 12'
      },
    ],
    'Miércoles (Legs - Piernas)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Prensa de piernas', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {'name': 'Peso muerto rumano', 'series': 'Series: 3', 'reps': 'Reps: 8'},
      {'name': 'Curl de piernas', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones de talones',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {'name': 'Zancadas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
    ],
    'Jueves (Push - Empuje)': [
      {'name': 'Press de banca', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {
        'name': 'Press inclinado con mancuernas',
        'series': 'Series: 4',
        'reps': 'Reps: 12'
      },
      {'name': 'Press militar', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {'name': 'Fondos en paralelas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {
        'name': 'Elevaciones laterales',
        'series': 'Series: 3',
        'reps': 'Reps: 12'
      },
      {
        'name': 'Extensiones de tríceps en polea',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
    ],
    'Viernes (Pull - Tracción)': [
      {'name': 'Dominadas', 'series': 'Series: 4', 'reps': 'Reps: 8'},
      {'name': 'Remo con barra', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Peso muerto', 'series': 'Series: 4', 'reps': 'Reps: 6'},
      {
        'name': 'Remo con mancuernas',
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
        'reps': 'Reps: 12'
      },
    ],
    'Sábado (Legs - Piernas)': [
      {'name': 'Sentadillas', 'series': 'Series: 4', 'reps': 'Reps: 10'},
      {'name': 'Prensa de piernas', 'series': 'Series: 4', 'reps': 'Reps: 12'},
      {'name': 'Peso muerto rumano', 'series': 'Series: 3', 'reps': 'Reps: 8'},
      {'name': 'Curl de piernas', 'series': 'Series: 3', 'reps': 'Reps: 10'},
      {
        'name': 'Elevaciones de talones',
        'series': 'Series: 3',
        'reps': 'Reps: 15'
      },
      {'name': 'Zancadas', 'series': 'Series: 3', 'reps': 'Reps: 12'},
    ],
  };

  Map<String, List<Map<String, String>>> get workoutDays => _workoutDays;
  List<Map<String, String>> getExercises(String day) {
    return _workoutDays[day] ?? [];
  }
}
