import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/Asignatura.dart';

class AsignaturaAPI{
  final String baseUrl = 'http://10.240.2.21:9090/api/asignaturas';

  // Obtener asignaturas
  Future<List<Asignaturas>> fetchAsignaturas() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Asignaturas.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar asignaturas:");
    }
  }

  // Obtener asignatura por ID
  Future<Asignaturas> fetchAsignaturaById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Asignaturas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al cargar asignatura con ID $id:");
    }
  }

  // Crear asignatura
  Future<Asignaturas> createAsignatura(Asignaturas asignatura) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(asignatura.toJson()..remove('id')),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Asignaturas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear asignatura:");
    }
  }

  // Actualizar asignatura
  Future<Asignaturas> updateAsignatura(Asignaturas asignatura) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${asignatura.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(asignatura.toJson()),
    );
    if (response.statusCode == 200) {
      return Asignaturas.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al actualizar asignatura:");
    }
  }

  // Eliminar asignatura
  Future<void> deleteAsignatura(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Error al eliminar asignatura:");
    }
  }
}