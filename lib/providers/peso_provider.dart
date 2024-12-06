import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PesoProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _historialPeso = [];
  bool _isLoading = false;

  // Getters
  List<Map<String, dynamic>> get historialPeso =>
      List.unmodifiable(_historialPeso);
  bool get isLoading => _isLoading;

  // Cargar el historial de peso desde Firestore
  Future<void> cargarHistorialPeso() async {
    _isLoading = true;

    // Asegura que notifyListeners no sea llamado durante la construcción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) {
      _isLoading = false;
      return;
    }

    try {
      _historialPeso.clear();

      // Cargar el peso inicial desde el perfil
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        final initialWeight = userDoc.data()?['weight'];
        final createdAt = userDoc.data()?['created_at']?.toDate();

        if (initialWeight != null && createdAt != null) {
          _historialPeso.add({
            'id': 'initial',
            'fecha': createdAt,
            'peso': initialWeight,
          });
        }
      }

      // Cargar el historial de pesos
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('weights')
          .orderBy('date', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        _historialPeso.add({
          'id': doc.id,
          'fecha': (data['date'] as Timestamp).toDate(),
          'peso': data['weight'],
        });
      }

      // Ordenar el peso inicial al principio
      _historialPeso.sort((a, b) => b['fecha'].compareTo(a['fecha']));
    } catch (e) {
      debugPrint('Error al cargar el historial de peso: $e');
    }

    _isLoading = false;

    // Aseguramos que se llame después del build inicial
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // Agregar un nuevo peso al historial en Firestore
  Future<void> agregarPeso(double peso) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    try {
      final docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('weights')
          .add({
        'weight': peso,
        'date': FieldValue.serverTimestamp(),
      });

      // Actualizar el historial en memoria
      _historialPeso.insert(0, {
        'id': docRef.id,
        'fecha': DateTime.now(),
        'peso': peso,
      });

      // Notificar los cambios después de asegurarse que el build haya terminado
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error al agregar un nuevo peso: $e');
    }
  }

  // Eliminar un peso del historial en Firestore
  Future<void> eliminarPeso(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId == null) return;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('weights')
          .doc(id)
          .delete();

      _historialPeso.removeWhere((peso) => peso['id'] == id);

      // Notificar los cambios después del build inicial
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    } catch (e) {
      debugPrint('Error al eliminar un peso: $e');
    }
  }
}
