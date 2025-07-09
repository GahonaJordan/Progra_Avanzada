import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Notas.dart';
import '../provider/notas_provider.dart';

class NotaCard extends ConsumerWidget {
  final Notas nota;

  const NotaCard({super.key, required this.nota});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: Text('Nota: ${nota.valor}'),
        subtitle: Text('Alumno ID: ${nota.alumnoId}, Asignatura ID: ${nota.asignaturaId}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ref.read(notasProvider.notifier).deleteNota(nota.id!);
          },
        ),
      ),
    );
  }
}