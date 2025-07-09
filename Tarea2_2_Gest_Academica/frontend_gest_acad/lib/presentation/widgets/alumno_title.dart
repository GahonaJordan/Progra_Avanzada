import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Alumno.dart';

class AlumnoTitle extends ConsumerWidget {
  final Alumnos alumno;

  const AlumnoTitle({super.key, required this.alumno});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          alumno.nombreCompleto,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text('Email: ${alumno.email ?? 'No disponible'}'),
        Text('Teléfono: ${alumno.telefono ?? 'No disponible'}'),
        Text('Dirección: ${alumno.direccion ?? 'No disponible'}'),
        Text('Fecha de nacimiento: ${alumno.fechaNacimiento ?? 'No disponible'}'),
        Text('Género: ${alumno.genero ?? 'No disponible'}'),
        Text('Estado civil: ${alumno.estadoCivil ?? 'No disponible'}'),
        Text('Nacionalidad: ${alumno.nacionalidad ?? 'No disponible'}'),
      ],
    );
  }
}
