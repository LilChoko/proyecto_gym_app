import 'package:flutter/material.dart';
import 'package:panthers_gym/providers/arnold_provider.dart';
import 'package:panthers_gym/providers/auth_provider.dart';
import 'package:panthers_gym/providers/bro_provider.dart';
import 'package:panthers_gym/providers/fullbody_provider.dart';
import 'package:panthers_gym/providers/heavy_provider.dart';
import 'package:panthers_gym/providers/ppl_provider.dart';
import 'package:panthers_gym/providers/theme_provider.dart';
import 'package:panthers_gym/providers/font_provider.dart';
import 'package:panthers_gym/providers/training_provider.dart';
import 'package:panthers_gym/providers/upperlower_provider.dart';
import 'package:panthers_gym/screens/login_screen.dart';
import 'package:panthers_gym/screens/home_screen.dart';
import 'package:panthers_gym/screens/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:panthers_gym/providers/cuestionario_provider.dart';
import 'package:panthers_gym/providers/consejos_provider.dart';
import 'package:panthers_gym/providers/peso_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ThemeProvider()..loadThemePreference()),
        ChangeNotifierProvider(
            create: (_) => FontProvider()..loadFontPreference()),
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadUserInfo()),
        ChangeNotifierProvider(create: (_) => CuestionarioProvider()),
        ChangeNotifierProvider(create: (_) => ConsejosProvider()),
        ChangeNotifierProvider(create: (_) => PesoProvider()),
        ChangeNotifierProvider(create: (_) => TrainingProvider()),
        ChangeNotifierProvider(create: (_) => ArnoldProvider()),
        ChangeNotifierProvider(create: (_) => BroProvider()),
        ChangeNotifierProvider(create: (_) => FullBodyProvider()),
        ChangeNotifierProvider(create: (_) => HeavyProvider()),
        ChangeNotifierProvider(create: (_) => PPLProvider()),
        ChangeNotifierProvider(create: (_) => UpperLowerProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final fontProvider = Provider.of<FontProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xFF0047AB),
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.black),
          bodyMedium: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.black),
          headlineLarge: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF0047AB),
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.white),
          bodyMedium: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.white),
          headlineLarge: TextStyle(
              fontFamily: fontProvider.selectedFont, color: Colors.white),
        ),
      ),
      themeMode: themeProvider.themeMode,
      initialRoute: '/login',
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
