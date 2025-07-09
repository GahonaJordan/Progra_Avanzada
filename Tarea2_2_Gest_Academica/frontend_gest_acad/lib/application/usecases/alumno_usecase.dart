import '../../../domain/entities/Alumno.dart';
import '../../data/repositories/alumno_repository_impl.dart';

class AlumnoUseCase {
  final AlumnoRepository repository;

  AlumnoUseCase(this.repository);

  Future<List<Alumnos>> fetchAll() => repository.getAlumnos();
  Future<Alumnos> create(Alumnos alumno) => repository.createAlumno(alumno);
  Future<Alumnos> update(Alumnos alumno) => repository.updateAlumno(alumno);
  Future<void> delete(int id) => repository.deleteAlumno(id);
}