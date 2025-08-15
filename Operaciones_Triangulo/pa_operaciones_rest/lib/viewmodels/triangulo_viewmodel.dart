import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/triangulo_model.dart';

class TrianguloViewModel extends ChangeNotifier{
  TrianguloModel? _triangulo;
  String? _error;
  bool _isLoading = false;

  // Nuevo: cliente y baseUrl configurables
  final http.Client client;
  String baseUrl;

  // Constructor modificado
  TrianguloViewModel({http.Client? client, String? baseUrl})
      : client = client ?? http.Client(),
        baseUrl = baseUrl ?? 'http://192.168.100.6:9090/api/triangulos';

  // GETTERS
  TrianguloModel? get triangulo => _triangulo;
  String? get error => _error;
  bool get isLoading => _isLoading;

  set triangulo(TrianguloModel? value) => _triangulo = value;
  set error(String? value) => _error = value;
  set isLoading(bool value) => _isLoading = value;

  Future<void> calcular(String operacion, double lado1, double lado2, double lado3) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse('$baseUrl/$operacion');

    try {
      final response = await client.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "lado1": lado1,
          "lado2": lado2,
          "lado3": lado3
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _triangulo = TrianguloModel(resultado: data['resultado']);
        _error = null;
      } else {
        _error = "Error: ${response.statusCode}";
        _triangulo = null;
      }
    } catch (e) {
      _error = "Error de conexión: $e";
      _triangulo = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}