import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_gest_acad/data/datasources/notas_api.dart';
import 'package:frontend_gest_acad/data/repositories/notas_repository_impl.dart';
import '../../domain/entities/Notas.dart';

class NotasNotifier extends StateNotifier<List<Notas>> {
  final NotasRepository repository;


  NotasNotifier(this.repository) : super([]) {
    loadNotas();
  }

  Future<void> loadNotas() async {
    try {
      final notas = await repository.getNotas();
      state = notas;
    } catch (e) {
      // Handle error, e.g., log it or show a message
      print('Error loading notas: $e');
    }
  }

  //leer las notas por Id del alumno

  Future<void> loadNotasPorAlumno(int alumnoId) async {
    try {
      final notas = await repository.getNotasconAlumnoId(alumnoId);
      state = notas;
    } catch (e) {
      print('Error al cargar notas por alumno: $e');
    }
  }


  Future<void> addNota(Notas nota) async {
    try {
      final newNota = await repository.createNota(nota);
      state = [...state, newNota];
    } catch (e) {
      // Handle error, e.g., log it or show a message
      print('Error crear la nota: $e');
    }
  }

  Future<void> updateNota(Notas updatedNota) async {
    try {
      final notaActualizada = await repository.updateNota(updatedNota);
      state = [
        for (final nota in state)
          if (nota.id == notaActualizada.id) notaActualizada else nota,
      ];
    } catch (e) {
      print('Error al actualizar la nota: $e');
    }
  }


  Future<void> deleteNota(int id) async {
    try {
      await repository.deleteNota(id);
      state = state.where((nota) => nota.id != id).toList();
    } catch (e) {
      print('Error al eliminar la nota: $e');
    }
  }

}

extension on Notas {
  Notas copyWith({
    int? id,
    double? valor,
    int? alumnoId,
    int? asignaturaId,
  }) {
    return Notas(
      id: id ?? this.id,
      valor: valor ?? this.valor,
      alumnoId: alumnoId ?? this.alumnoId,
      asignaturaId: asignaturaId ?? this.asignaturaId,
    );
  }
}

final notasProvider = StateNotifierProvider<NotasNotifier, List<Notas>>((ref) {
  final api = NotasAPI();
  final repo = NotasRepository(api);
  return NotasNotifier(repo);
});