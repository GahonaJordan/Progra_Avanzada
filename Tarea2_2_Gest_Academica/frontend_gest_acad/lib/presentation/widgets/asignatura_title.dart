import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Asignatura.dart';
import '../provider/asignaturas_provider.dart';

class AsignaturaTitle extends ConsumerWidget {
  final Asignaturas asignatura;

  const AsignaturaTitle({super.key, required this.asignatura});

  @override
  Widget build(BuildContext , WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          asignatura.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text('Descripción: ${asignatura.descripcion}'),
        Text('Créditos: ${asignatura.creditos}'),
        Text('Semestre: ${asignatura.semestre}'),
        Text('Profesor: ${asignatura.profesor}'),
      ],
    );
  }
}