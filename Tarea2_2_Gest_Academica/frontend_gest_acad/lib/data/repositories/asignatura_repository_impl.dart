import '../../domain/entities/Asignatura.dart';
import '../datasources/asignatura_api.dart';

class AsignaturaRepository {
  final AsignaturaAPI api;

  AsignaturaRepository(this.api);

  Future<List<Asignaturas>> getAsignaturas() => api.fetchAsignaturas();
  Future<Asignaturas> createAsignatura(Asignaturas asignatura) => api.createAsignatura(asignatura);
  Future<Asignaturas> updateAsignatura(Asignaturas asignatura) => api.updateAsignatura(asignatura);
  Future<void> deleteAsignatura(int id) => api.deleteAsignatura(id);
}