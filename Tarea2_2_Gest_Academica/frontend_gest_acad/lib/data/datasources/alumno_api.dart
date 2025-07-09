import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/Alumno.dart';

class AlumnoAPI{
  // URL base de la API
  final String baseUrl = 'http://10.240.2.21:9090/api/alumnos';

  // Obtener alumnos
  Future<List<Alumnos>> fetchAlumnos() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Alumnos.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar alumnos:");
    }
  }

  // Obtener alumno por ID
  Future<Alumnos> fetchAlumnoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      return Alumnos.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al cargar alumno con ID $id:");
    }
  }

  // Crear alumno
  Future<Alumnos> createAlumno(Alumnos alumno) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(alumno.toJson()..remove('id')),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Alumnos.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al crear alumno:");
    }
  }

  // Actualizar alumno
  Future<Alumnos> updateAlumno(Alumnos alumno) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${alumno.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(alumno.toJson()),
    );
    if (response.statusCode == 200) {
      return Alumnos.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Error al actualizar alumno:");
    }
  }

  // Eliminar alumno
  Future<void> deleteAlumno(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Error al eliminar alumno:");
    }
  }
}
