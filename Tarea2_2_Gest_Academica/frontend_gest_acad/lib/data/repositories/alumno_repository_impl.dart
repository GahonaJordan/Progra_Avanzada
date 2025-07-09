import '../../domain/entities/Alumno.dart';
import '../datasources/alumno_api.dart';

class AlumnoRepository {
  final AlumnoAPI api;

  AlumnoRepository(this.api);

  Future<List<Alumnos>> getAlumnos() => api.fetchAlumnos();
  Future<Alumnos> createAlumno(Alumnos alumno) => api.createAlumno(alumno);
  Future<Alumnos> updateAlumno(Alumnos alumno) => api.updateAlumno(alumno);
  Future<void> deleteAlumno(int id) => api.deleteAlumno(id);
}