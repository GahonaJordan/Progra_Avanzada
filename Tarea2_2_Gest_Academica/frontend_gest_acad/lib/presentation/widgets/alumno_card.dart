import 'package:flutter/material.dart';
import '../../domain/entities/Alumno.dart';
import 'alumno_title.dart';

class AlumnoCard extends StatelessWidget {
  final Alumnos alumno;
  final VoidCallback onVerNotas;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const AlumnoCard({
    Key? key,
    required this.alumno,
    required this.onVerNotas,
    required this.onEditar,
    required this.onEliminar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Icon(Icons.person, size: 28),
                  radius: 28,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    alumno.nombreCompleto,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Divider(),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(alumno.email ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(alumno.telefono ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text(alumno.direccion ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.cake),
              title: Text(alumno.fechaNacimiento ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.wc),
              title: Text(alumno.genero ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: Text(alumno.estadoCivil ?? 'No disponible'),
            ),
            ListTile(
              leading: const Icon(Icons.flag),
              title: Text(alumno.nacionalidad ?? 'No disponible'),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: onVerNotas,
                  icon: const Icon(Icons.note),
                  label: const Text('Ver Notas'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Editar',
                  onPressed: onEditar,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  tooltip: 'Eliminar',
                  onPressed: onEliminar,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}