import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapProvider with ChangeNotifier {
  LatLng _currentLocation =
      LatLng(20.526707181788908, -100.83539324561085); // Ubicación inicial
  double _zoom = 16.0; // Nivel de zoom inicial

  // Getters
  LatLng get currentLocation => _currentLocation;
  double get zoom => _zoom;

  // Métodos para actualizar estado
  void updateLocation(LatLng newLocation) {
    _currentLocation = newLocation;
    notifyListeners();
  }

  void updateZoom(double newZoom) {
    _zoom = newZoom;
    notifyListeners();
  }
}
