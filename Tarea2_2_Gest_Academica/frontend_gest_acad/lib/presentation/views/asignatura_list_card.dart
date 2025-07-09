import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Asignatura.dart';
import '../provider/asignaturas_provider.dart';

class AsignaturaListPage extends ConsumerWidget {
  const AsignaturaListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asignaturas = ref.watch(asignaturasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Asignaturas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/asignatura_form');
            },
          )
        ],
      ),
      body: asignaturas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: asignaturas.length,
        itemBuilder: (context, index) {
          final asignatura = asignaturas[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.book, size: 28),
                        radius: 28,
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          asignatura.nombre,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Divider(),
                  ListTile(
                    leading: const Icon(Icons.description),
                    title: Text(asignatura.descripcion),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Text('Créditos: ${asignatura.creditos}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text('Semestre: ${asignatura.semestre}'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text('Profesor: ${asignatura.profesor}'),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.edit, color: Colors.deepPurple),
                        label: const Text('Editar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.deepPurple,
                          side: const BorderSide(color: Colors.deepPurple),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/asignatura_form',
                            arguments: asignatura,
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        label: const Text('Eliminar'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          ref.read(asignaturasProvider.notifier).deleteAsignatura(asignatura.id!);
                        },
                      ),
                    ],
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