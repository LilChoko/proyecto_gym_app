import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _userName;

  // Getters
  bool get isLoading => _isLoading;
  String? get userName => _userName;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Obtener el nombre de usuario desde Firestore
  Future<String?> fetchUserName() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return 'Invitado';

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        _userName = userDoc.data()?['name'] as String?;
        notifyListeners();
        return _userName;
      }
    } catch (e) {
      debugPrint('Error al obtener el nombre de usuario: $e');
    }

    return 'Invitado';
  }

  // Verificar si el cuestionario está completo
  Future<bool> isQuestionnaireCompleted() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return false;

    try {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc.data()?['completed_questionnaire'] ?? false;
      }
    } catch (e) {
      debugPrint('Error al verificar el estado del cuestionario: $e');
    }

    return false;
  }

  // Cerrar sesión
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _userName = null;
    notifyListeners();
  }

  // Iniciar sesión con correo y contraseña
  Future<void> signInWithEmail(
      String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      // Verificar si el correo está verificado
      if (user != null && !user.emailVerified) {
        throw FirebaseAuthException(
          code: 'email-not-verified',
          message: 'Por favor, verifica tu correo electrónico.',
        );
      }

      if (user == null) {
        throw Exception('No hay un usuario autenticado.');
      }

      // Verificar el estado del cuestionario en Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception('Error al obtener los datos del usuario.');
      }

      final completedQuestionnaire =
          userDoc.data()?['completed_questionnaire'] ?? false;

      // Redirigir basado en el estado del cuestionario
      if (completedQuestionnaire) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/cuestionario');
      }
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

        // Guardar estado inicial del cuestionario en Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': email,
          'name': null,
          'completed_questionnaire': false,
          'created_at': FieldValue.serverTimestamp(),
        });
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
