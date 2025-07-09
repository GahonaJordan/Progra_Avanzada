import '../../domain/entities/Asignatura.dart';
import '../../data/repositories/asignatura_repository_impl.dart';

class AsignaturaUseCase {
  final AsignaturaRepository repository;

  AsignaturaUseCase(this.repository);

  Future<List<Asignaturas>> fetchAll() => repository.getAsignaturas();
  Future<Asignaturas> create(Asignaturas asignatura) => repository.createAsignatura(asignatura);
  Future<Asignaturas> update(Asignaturas asignatura) => repository.updateAsignatura(asignatura);
  Future<void> delete(int id) => repository.deleteAsignatura(id);
}