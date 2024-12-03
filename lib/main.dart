import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/firebase_options.dart';
import 'screens/login_screen.dart'; // Importa las pantallas creadas
import 'screens/cuestionario1_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Configuramos las rutas
      initialRoute: '/cuestionario',
      routes: {
        '/login': (context) => LoginScreen(),
        '/cuestionario': (context) => CuestionarioScreen(),
      },
    );
  }
}
