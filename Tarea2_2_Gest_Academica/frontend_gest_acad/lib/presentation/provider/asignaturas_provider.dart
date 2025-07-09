import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_gest_acad/data/datasources/asignatura_api.dart';
import 'package:frontend_gest_acad/data/repositories/asignatura_repository_impl.dart';
import 'package:frontend_gest_acad/data/repositories/notas_repository_impl.dart';
import '../../domain/entities/Asignatura.dart';

class AsignaturasNotier extends StateNotifier<List<Asignaturas>> {
  final AsignaturaRepository asignaturaRepository;


  AsignaturasNotier(this.asignaturaRepository) : super([]) {
    loadAsignaturas();
  }

  Future<void> loadAsignaturas() async {
    try {
      final asignaturas = await asignaturaRepository.getAsignaturas();
      state = asignaturas;
    } catch (e) {
      // Manejo de errores, por ejemplo, puedes imprimir el error o mostrar un mensaje al usuario
      print('Error al cargar las asignaturas: $e');
    }
  }

  Future<void> addAsignatura(Asignaturas asignatura) async {
    try { //genera un nuevo id si es necesario o si no no
      final nuevaAsignatura = await asignaturaRepository.createAsignatura(asignatura);
      state = [...state, nuevaAsignatura];
    } catch (e) {
      // Manejo de errores, por ejemplo, puedes imprimir el error o mostrar un mensaje al usuario
      print('Error al agregar la asignatura: $e');
    }
  }

  Future<void> updateAsignatura(Asignaturas updatedAsignatura) async {
    try{
      state = [
        for (final asignatura in state)
          if (asignatura.id == updatedAsignatura.id) updatedAsignatura else
            asignatura
      ];
    } catch (e) {
      // Manejo de errores, por ejemplo, puedes imprimir el error o mostrar un mensaje al usuario
      print('Error al actualizar la asignatura: $e');
    }
  }

  void deleteAsignatura(int id) {
    try {
      // Filtra la lista de asignaturas para eliminar la asignatura con el ID especificado
      state = state.where((asignatura) => asignatura.id != id).toList();
    } catch (e) {
      // Manejo de errores, por ejemplo, puedes imprimir el error o mostrar un mensaje al usuario
      print('Error al eliminar la asignatura: $e');
    }
  }
}

extension on Asignaturas {
  Asignaturas copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    int? creditos,
    String? semestre,
    String? profesor,
  }) {
    return Asignaturas(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      creditos: creditos ?? this.creditos,
      semestre: semestre ?? this.semestre,
      profesor: profesor ?? this.profesor,
    );
  }
}

final asignaturasProvider = StateNotifierProvider<AsignaturasNotier, List<Asignaturas>>((ref) {
  final api = AsignaturaAPI();
  final repo = AsignaturaRepository(api);
  return AsignaturasNotier(repo);
});