import 'package:flutter/material.dart';
import 'package:panthers_gym/splits/bro_screen.dart';
import 'package:panthers_gym/splits/fullbody_screen.dart';
import 'package:panthers_gym/splits/heavy_screen.dart';
import 'package:panthers_gym/splits/arnold_screen.dart';
import 'package:panthers_gym/splits/ppl_screen.dart';
import 'package:panthers_gym/splits/upperlower_screen.dart';

class TrainingProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _trainingPrograms = [
    {
      'title': 'Heavy Duty',
      'image': 'assets/heavy.jpg',
      'screen': HeavyScreen()
    },
    {
      'title': 'Arnold Split',
      'image': 'assets/arnold1.jpg',
      'screen': ArnoldScreen()
    },
    {
      'title': 'Push, Pull, Legs (PPL)',
      'image': 'assets/tr3.jpg',
      'screen': PPLScreen()
    },
    {
      'title': 'Upper/Lower Split',
      'image': 'assets/phul.jpg',
      'screen': UpperLowerScreen()
    },
    {
      'title': 'Bro Split',
      'image': 'assets/brosplit.jpg',
      'screen': BroScreen()
    },
    {
      'title': 'Full Body',
      'image': 'assets/tr2.jpg',
      'screen': FullBodyScreen()
    },
  ];

  List<Map<String, dynamic>> get trainingPrograms =>
      List.unmodifiable(_trainingPrograms);

  void navigateToProgram(BuildContext context, int index) {
    if (index < _trainingPrograms.length) {
      final screen = _trainingPrograms[index]['screen'] as Widget;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pantalla no disponible aún')),
      );
    }
  }
}
