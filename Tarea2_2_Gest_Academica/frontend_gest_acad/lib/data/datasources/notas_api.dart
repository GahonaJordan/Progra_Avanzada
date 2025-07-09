import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/Notas.dart';

class NotasAPI{
  final String baseUrl = 'http://10.240.2.21:9090/api/nota';

  // Obtener notas
  Future<List<Notas>> fetchNotas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Notas.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar notas:");
    }
  }

  // Obtener nota por ID del alumno
  Future<List<Notas>> fetchNotaByalumnoId(int alumnoId) async {
    final response = await http.get(Uri.parse('$baseUrl/alumno/$alumnoId'));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Notas.fromJson(e)).toList();
    } else {
      throw Exception("Error al cargar notas del alumno con ID $alumnoId:");
    }
  }

  // Crear nota
  Future<Notas> createNota(Notas nota) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(nota.toJson()..remove('id')),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Notas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear nota:");
    }
  }

  // Actualizar nota
  Future<Notas> updateNota(Notas nota) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${nota.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(nota.toJson()),
    );
    if (response.statusCode == 200) {
      return Notas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al actualizar nota:");
    }
  }

  // Eliminar nota
  Future<void> deleteNota(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Error al eliminar nota:");
    }
  }
}