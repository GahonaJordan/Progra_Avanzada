import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_gest_acad/domain/entities/Alumno.dart';
import '../../domain/entities/Notas.dart';
import '../provider/notas_provider.dart';
import '../widgets/nota_title.dart';

class NotaListCard extends ConsumerWidget {
  final int? alumnoId;

  const NotaListCard({Key? key, this.alumnoId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notas = ref.watch(notasProvider);
    // Filtra las notas por el id del alumno recibido
    final notasAlumno = alumnoId == null
        ? notas
        : notas.where((n) => n.alumnoId == alumnoId).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notas del Alumno'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/nota_form',
                arguments: {
                  'alumnoId': alumnoId,
                  'nota': null,
                },
              );
            },
          )
        ],
      ),
      body: notasAlumno.isEmpty
          ? const Center(child: Text('No hay notas registradas para este alumno'))
          : ListView.builder(
        itemCount: notasAlumno.length,
        itemBuilder: (context, index) {
          final nota = notasAlumno[index];
          return Card(
            child: ListTile(
              title: NotaTitle(nota: nota),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/nota_form',
                        arguments: {
                          'alumnoId': alumnoId,
                          'nota': nota,
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      ref.read(notasProvider.notifier).deleteNota(nota.id!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
