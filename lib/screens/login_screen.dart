import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';
import 'cuestionario1_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = firebase_auth.FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[^@]+@[^@]+\.[^@]+").hasMatch(email);
  }

  String _getFirebaseAuthErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'Este correo ya está registrado.';
      case 'invalid-email':
        return 'El correo introducido no es válido.';
      case 'weak-password':
        return 'La contraseña es muy débil.';
      case 'user-not-found':
        return 'No se encontró ningún usuario con este correo.';
      case 'wrong-password':
        return 'La contraseña es incorrecta.';
      default:
        return 'Ocurrió un error. Inténtalo nuevamente.';
    }
  }

  Future<void> _sendPasswordReset() async {
    final email = _emailController.text.trim();

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    _setLoading(true);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showMessage('Se ha enviado un correo para restablecer tu contraseña.');
    } on firebase_auth.FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _resendVerificationEmail() async {
    try {
      firebase_auth.User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        _showMessage('Correo de verificación reenviado a ${user.email}.');
      } else {
        _showMessage('El usuario ya está verificado o no está autenticado.');
      }
    } catch (e) {
      _showMessage('Error al reenviar correo de verificación.');
    }
  }

  Future<void> _signInWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    if (password.isEmpty) {
      _showMessage('La contraseña no puede estar vacía.');
      return;
    }

    _setLoading(true);
    try {
      firebase_auth.UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!userCredential.user!.emailVerified) {
        _showMessage(
          'Tu correo no está verificado. Por favor, revisa tu bandeja de entrada.',
        );
      } else {
        // Verificar si el cuestionario ya fue completado
        final prefs = await SharedPreferences.getInstance();
        final completedQuestionnaire =
            prefs.getBool('completedQuestionnaire') ?? false;

        if (completedQuestionnaire) {
          // Si ya completó el cuestionario, redirigir al HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Si no, redirigir al Cuestionario
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CuestionarioScreen()),
          );
        }
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _handlePostLogin(String userId) async {
    // Leer el estado de `completedQuestionnaire` desde SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final hasCompletedQuestionnaire =
        prefs.getBool('completedQuestionnaire_$userId') ?? false;

    if (!hasCompletedQuestionnaire) {
      // Redirigir al cuestionario si no lo ha completado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CuestionarioScreen()),
      );
    } else {
      // Redirigir al HomeScreen si ya completó el cuestionario
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future<void> _registerWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!_isValidEmail(email)) {
      _showMessage('Por favor, introduce un correo válido.');
      return;
    }

    if (password.isEmpty) {
      _showMessage('La contraseña no puede estar vacía.');
      return;
    }

    _setLoading(true);
    try {
      firebase_auth.UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        _showMessage(
          'Se ha enviado un correo de verificación a $email. Por favor, verifica tu cuenta antes de iniciar sesión.',
        );
      }

      // Guardar el estado de `completedQuestionnaire` en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(
          'completedQuestionnaire_${userCredential.user!.uid}', false);
    } on firebase_auth.FirebaseAuthException catch (e) {
      _showMessage(_getFirebaseAuthErrorMessage(e.code));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _showMessage(String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxHeight > constraints.maxWidth;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: isPortrait
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: isPortrait ? 20 : 0),
                        ClipOval(
                          child: Image.asset(
                            'assets/panther_gym_logo.png',
                            height: isPortrait ? 100 : 80,
                            width: isPortrait ? 100 : 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: isPortrait ? 40 : 20),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: textTheme.bodyMedium,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: textTheme.bodyMedium,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isLoading ? null : _signInWithEmail,
                          child: Text('Iniciar sesión'),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _registerWithEmail,
                          child: Text('¿No tienes cuenta? Regístrate'),
                        ),
                        TextButton(
                          onPressed: _isLoading ? null : _sendPasswordReset,
                          child: Text('¿Olvidaste tu contraseña?'),
                        ),
                        TextButton(
                          onPressed:
                              _isLoading ? null : _resendVerificationEmail,
                          child: Text('Reenviar confirmación de cuenta'),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              if (_isLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }
}
