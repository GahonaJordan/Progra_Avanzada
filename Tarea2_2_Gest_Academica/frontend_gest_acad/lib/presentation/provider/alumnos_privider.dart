import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Alumno.dart';
import '../../data/datasources/alumno_api.dart';
import '../../data/repositories/alumno_repository_impl.dart';


class AlumnosNotifier extends StateNotifier<List<Alumnos>> {
  final AlumnoRepository repositor;

  AlumnosNotifier(this.repositor) : super([]) {
    loadAlumnos();
  }

  Future<void> loadAlumnos() async {
    try {
      final alumnos = await repositor.getAlumnos();
      state = alumnos;
    } catch (e) {
      print('Error al cargar los alumnos: $e');
    }
  }

  Future<void> addAlumno(Alumnos alumno) async {
    try {
      final nuevoAlumno = await repositor.createAlumno(alumno);
      state = [...state, nuevoAlumno];
    } catch (e) {
      print('Error al agregar alumno: $e');
    }
  }

  Future<void> updateAlumno(Alumnos updatedAlumno) async {
    try {
      final updated = await repositor.updateAlumno(updatedAlumno);
      state = [
        for (final alumno in state)
          if (alumno.id == updated.id) updated else
            alumno
      ];
    } catch (e) {
      print('Error al actualizar alumno: $e');
    }
  }

  Future<void> deleteAlumno(int id) async {
    try {
      await repositor.deleteAlumno(id);
      state = state.where((alumno) => alumno.id != id).toList();
    } catch (e) {
      print('Error al eliminar alumno: $e');
    }
  }
}

extension on Alumnos{
  Alumnos copyWith({
    int? id,
    String? nombreCompleto,
    String? email,
    String? telefono,
    String? direccion,
    String? fechaNacimiento,
    String? genero,
    String? estadoCivil,
    String? nacionalidad,}) {
    return Alumnos(
      id: id ?? this.id,
      nombreCompleto: nombreCompleto ?? this.nombreCompleto,
      email: email ?? this.email,
      telefono: telefono ?? this.telefono,
      direccion: direccion ?? this.direccion,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      genero: genero ?? this.genero,
      estadoCivil: estadoCivil ?? this.estadoCivil,
      nacionalidad: nacionalidad ?? this.nacionalidad,
    );
  }
}

final alumnosProvider = StateNotifierProvider<AlumnosNotifier, List<Alumnos>>((ref) {
  final api = AlumnoAPI();
  final repo = AlumnoRepository(api);
  return AlumnosNotifier(repo);
});