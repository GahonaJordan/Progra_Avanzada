import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/operacion_request.dart';

class OperacionViewModel extends ChangeNotifier {
  double? resultado;
  String baseUrl = "http://10.9.4.174:9090/api/operaciones"; // para Android Emulator
//
  final http.Client httpClient;

  OperacionViewModel({http.Client? client}) : httpClient = client ?? http.Client();


  Future<void> calcular(String operacion, double numero1, double numero2) async {
    final uri = Uri.parse('$baseUrl/$operacion');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(OperacionRequest(numero1: numero1, numero2: numero2).toJson()),
    );

    if (response.statusCode == 200) {
      resultado = jsonDecode(response.body)['resultado'];
    } else {
      resultado = null;
    }

    notifyListeners();
  }
}
