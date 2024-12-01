import 'package:flutter/material.dart';
import 'package:panthers_gym/consejos_screen.dart';
import 'package:panthers_gym/home_screen.dart';
import 'package:panthers_gym/peso_screen.dart';
import 'package:panthers_gym/profile_screen.dart';
import 'package:panthers_gym/training_screen.dart';
import 'login_screen.dart'; // Importa las pantallas creadas
import 'cuestionario1_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Configuramos las rutas
      initialRoute: '/home',
      routes: {
        '/login': (context) => LoginScreen(),
        '/cuestionario': (context) => CuestionarioScreen(),
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/pesoTabla': (context) => PesoScreen(),
        '/entrenamientos': (context) => TrainingScreen(),
        '/consejos': (context) => ConsejosScreen(),
      },
    );
  }
}
