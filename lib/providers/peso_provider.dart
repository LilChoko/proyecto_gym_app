import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PesoProvider with ChangeNotifier {
  final List<Map<String, String>> _historialPeso = [];

  List<Map<String, String>> get historialPeso =>
      List.unmodifiable(_historialPeso);

  void agregarPeso(DateTime fecha, String peso) {
    _historialPeso.add({
      'fecha': DateFormat('dd/MM/yyyy').format(fecha),
      'peso': peso,
    });
    notifyListeners();
  }

  void eliminarPeso(int index) {
    _historialPeso.removeAt(index);
    notifyListeners();
  }
}
