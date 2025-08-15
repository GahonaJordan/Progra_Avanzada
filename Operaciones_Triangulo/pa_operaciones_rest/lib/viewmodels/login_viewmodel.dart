import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    // Convertimos las credenciales a base64 para Basic Auth
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    try {
      // Intenta acceder a una ruta protegida
      final response = await http.post(
        Uri.parse('http://192.168.100.6:9090/api/usuarios/login'),
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _isAuthenticated = false;
        _errorMessage = 'Credenciales incorrectas';
      }
    } catch (e) {
      _isAuthenticated = false;
      _errorMessage = 'Error al conectar con el servidor';
    }

    notifyListeners();
  }
}
