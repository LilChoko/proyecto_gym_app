import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:panthers_gym/screens/home_screen.dart';
import 'package:panthers_gym/screens/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ValueNotifier para el tema
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.light);

// ValueNotifier para la fuente seleccionada
final ValueNotifier<String> selectedFontNotifier =
    ValueNotifier<String>('Roboto');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializa Supabase
  await Supabase.initialize(
    url: 'https://iuquhvgkjvmjjrdhaget.supabase.co', // Reemplaza con tu URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1cXVodmdranZtampyZGhhZ2V0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMyOTU1OTgsImV4cCI6MjA0ODg3MTU5OH0.x_3dluR-0iS5_ScJtfeM87Po19M8b8OvH5ZKUQ23CHo', // Reemplaza con tu clave API anónima
  );

  // Cargar configuraciones de usuario
  await loadPreferences();

  runApp(const MainApp());
}

// Cargar configuraciones de fuente y tema
Future<void> loadPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final savedFont = prefs.getString('selectedFont') ?? 'Roboto';
  final isDark = prefs.getBool('isDarkTheme') ?? false;

  selectedFontNotifier.value = savedFont;
  themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
}

// Guardar configuración de tema
Future<void> saveThemePreference(bool isDark) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkTheme', isDark);
}

// Guardar configuración de fuente
Future<void> saveFontPreference(String font) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('selectedFont', font);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<String>(
          valueListenable: selectedFontNotifier,
          builder: (context, fontFamily, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: const Color(0xFF0047AB), // Azul principal
                scaffoldBackgroundColor: Colors.white,
                textTheme: TextTheme(
                  bodyLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.black),
                  bodyMedium:
                      TextStyle(fontFamily: fontFamily, color: Colors.black),
                  headlineLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.black),
                  headlineMedium:
                      TextStyle(fontFamily: fontFamily, color: Colors.black),
                  titleLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.black),
                ),
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF0047AB), // Azul principal
                scaffoldBackgroundColor:
                    const Color(0xFF121212), // Fondo oscuro
                textTheme: TextTheme(
                  bodyLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.white),
                  bodyMedium:
                      TextStyle(fontFamily: fontFamily, color: Colors.white),
                  headlineLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.white),
                  headlineMedium:
                      TextStyle(fontFamily: fontFamily, color: Colors.white),
                  titleLarge:
                      TextStyle(fontFamily: fontFamily, color: Colors.white),
                ),
              ),
              themeMode: themeMode,
              initialRoute: '/login',
              routes: {
                '/home': (context) => HomeScreen(),
                '/login': (context) => LoginScreen(),
              },
            );
          },
        );
      },
    );
  }
}
