// lib/viewmodels/operacion_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/operacion_model.dart';

class OperacionViewModel extends ChangeNotifier {
  OperacionModel? _operacion;
  String? _error;
  bool _isLoading = false;
  String? _username;
  String? _password;

  // Método para guardar credenciales
  void setCredentials(String username, String password) {
    _username = username;
    _password = password;
  }

  // Nuevo: cliente y baseUrl configurables
  final http.Client client;
  String baseUrl;

  // Constructor modificado
  OperacionViewModel({http.Client? client, String? baseUrl})
      : client = client ?? http.Client(),
        baseUrl = baseUrl ?? 'http://192.168.100.6:9090/api/operaciones';

  // GETTERS
  OperacionModel? get operacion => _operacion;
  String? get error => _error;
  bool get isLoading => _isLoading;

  set operacion(OperacionModel? value) => _operacion = value;
  set error(String? value) => _error = value;
  set isLoading(bool value) => _isLoading = value;

  Future<void> calcular(String operacion, double numero1, double numero2) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/$operacion');

    // Construir la cabecera básica con usuario y contraseña
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_username:$_password'));

    final response = await client.post(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({"numero1": numero1, "numero2": numero2}),
    );

    try {
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _operacion = OperacionModel(resultado: data['resultado']);
        _error = null;
      } else {
        _error = "Error: ${response.statusCode}";
        _operacion = null;
      }
    } catch (e) {
      _error = "Error de conexión: $e";
      _operacion = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}