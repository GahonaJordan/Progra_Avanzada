import '../../domain/entities/Notas.dart';
import '../../data/repositories/notas_repository_impl.dart';

class NotasUseCase {
  final NotasRepository repository;

  NotasUseCase(this.repository);

  Future<List<Notas>> fetchAll() => repository.getNotas();
  Future<List<Notas>> fetchAlumnoId(int alumnoId) {
    return repository.getNotasconAlumnoId(alumnoId);
  }
  Future<Notas> create(Notas nota) => repository.createNota(nota);
  Future<Notas> update(Notas nota) => repository.updateNota(nota);
  Future<void> delete(int id) => repository.deleteNota(id);
}