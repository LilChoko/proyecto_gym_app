import 'package:flutter/material.dart';
import 'package:panthers_gym/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:panthers_gym/screens/home_screen.dart';
import 'package:panthers_gym/screens/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

// ValueNotifier para el tema
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier<ThemeMode>(ThemeMode.light);

// ValueNotifier para la fuente seleccionada
final ValueNotifier<String> selectedFontNotifier =
    ValueNotifier<String>('Roboto');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await loadPreferences(); // Cargar configuraciones de usuario
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
                primaryColor: Color(0xFF0047AB), // Azul principal
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
                primaryColor: Color(0xFF0047AB), // Azul principal
                scaffoldBackgroundColor: Color(0xFF121212), // Fondo oscuro
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
