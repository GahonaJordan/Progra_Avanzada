import '../../domain/entities/Notas.dart';
import '../datasources/notas_api.dart';

class NotasRepository {
  final NotasAPI api;

  NotasRepository(this.api);

  Future<List<Notas>> getNotas() => api.fetchNotas();
  Future<List<Notas>> getNotasconAlumnoId(int alumnoId) {
    return api.fetchNotaByalumnoId(alumnoId);
  }
  Future<Notas> createNota(Notas nota) => api.createNota(nota);
  Future<Notas> updateNota(Notas nota) => api.updateNota(nota);
  Future<void> deleteNota(int id) => api.deleteNota(id);
}