import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistrarViewModel extends ChangeNotifier {
  bool _isRegistered = false;
  String? _errorMessage;

  bool get isRegistered => _isRegistered;
  String? get errorMessage => _errorMessage;

  Future<void> register(String nombre, String apellido, String email,
      String userName, String password) async {
    final url = Uri.parse('http://192.168.100.6:9090/api/usuarios/registro');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'nombre': nombre,
      'apellido': apellido,
      'email': email,
      'userName': userName, // importante: coincide con tu DTO
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isRegistered = true;
        _errorMessage = null;
      } else {
        _isRegistered = false;
        _errorMessage = 'Error al registrar: ${response.body}';
      }
    } catch (e) {
      _isRegistered = false;
      _errorMessage = 'Error de conexión: $e';
    }
    notifyListeners();
  }
}
