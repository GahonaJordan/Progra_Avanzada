import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Alumno.dart';
import '../provider/alumnos_privider.dart';
import '../widgets/alumno_title.dart';
import '../widgets/alumno_card.dart';

class AlumnoListPage extends ConsumerWidget {
  const AlumnoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alumnos = ref.watch(alumnosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Alumnos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar al formulario de creación (lo creamos luego)
              Navigator.pushNamed(context, '/alumno_form');
            },
          )
        ],
      ),
      body: alumnos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: alumnos.length,
        itemBuilder: (context, index) {
          final alumno = alumnos[index];
          return AlumnoCard(
                    alumno: alumno,
                    onVerNotas: () {
                      Navigator.pushNamed(
                        context,
                        '/notas_list',
                        arguments: alumno.id,
                      );
                    },
                    onEditar: () {
                      Navigator.pushNamed(context, '/alumno_form', arguments: alumno);
                    },
                    onEliminar: () {
                      ref.read(alumnosProvider.notifier).deleteAlumno(alumno.id!);
                    },
          );
        },
      ),
    );
  }
}
