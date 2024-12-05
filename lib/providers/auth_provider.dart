import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? _userName;
  bool _isLoading = false;

  // Getter para el nombre del usuario
  String? get userName => _userName;

  // Getter para el estado de carga
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Método para cargar información del usuario actual
  Future<void> loadUserInfo() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      _userName = user.displayName ?? 'Usuario';
      notifyListeners();
    }
  }

  // Método para cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();

    // Limpiar SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _userName = null;
    notifyListeners();
  }

  // Iniciar sesión con correo y contraseña
  Future<void> signInWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Verificar si el usuario es nulo
      if (user == null) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No se encontró ningún usuario.',
        );
      }

      // Verificar si el correo está verificado
      if (!user.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Por favor, verifica tu correo electrónico.',
        );
      }

      // Pasar UID del usuario
      await _handlePostLogin(user.uid);
    } on FirebaseAuthException catch (e) {
      throw _getFirebaseAuthErrorMessage(e.code);
    } finally {
      _setLoading(false);
    }
  }

  // Registrar nuevo usuario con correo y contraseña
  Future<void> registerWithEmail(String email, String password) async {
    _setLoading(true);
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();

        // Guardar estado inicial del cuestionario en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('completedQuestionnaire_${user.uid}', false);
      }
    } on FirebaseAuthException catch (e) {
      throw _getFirebaseAuthErrorMessage(e.code);
    } finally {
      _setLoading(false);
    }
  }

  // Restablecer contraseña
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw 'No se pudo enviar el correo de restablecimiento.';
    }
  }

  // Reenviar correo de verificación
  Future<void> resendVerificationEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    } else {
      throw 'El usuario ya está verificado o no está autenticado.';
    }
  }

  // Manejo posterior al inicio de sesión
  Future<void> _handlePostLogin(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final completedQuestionnaire =
        prefs.getBool('completedQuestionnaire_$userId') ?? false;

    if (!completedQuestionnaire) {
      throw 'questionnaire';
    }
  }

  // Obtener mensajes de error de FirebaseAuth
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
      case 'email-not-verified':
        return 'Por favor, verifica tu correo electrónico.';
      default:
        return 'Ocurrió un error. Inténtalo nuevamente.';
    }
  }
}
