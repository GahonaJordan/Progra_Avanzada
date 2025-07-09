import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_gest_acad/presentation/views/asignatura_list_card.dart';
import 'package:frontend_gest_acad/presentation/views/asignatura_form_page.dart';
import 'package:frontend_gest_acad/presentation/views/notas_form_page.dart';
import 'package:frontend_gest_acad/presentation/views/notas_list_card.dart';
import 'presentation/views/alumno_list_card.dart';
import 'presentation/views/alumno_form_page.dart';
import '../../domain/entities/Alumno.dart';
import '../../domain/entities/Asignatura.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alumnos CRUD',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const MainMenu(),
      routes: {
        '/alumnos': (_) => const AlumnoListPage(),
        '/asignaturas': (_) => const AsignaturaListPage(), // Debes crear esta página
        //rutas para alumnos
        '/alumno_form': (context) {
          final alumno = ModalRoute.of(context)!.settings.arguments as Alumnos?;
          return AlumnoFormPage(alumno: alumno);
          },
        //rutas para asignaturas
        '/asignatura_form': (context) {
          final asignatura = ModalRoute.of(context)!.settings.arguments as Asignaturas?;
          return AsignaturaFormPage(asignatura: asignatura);
        },
        //rutas para notas
          '/nota_form': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return NotaFormPage(
              alumnoId: args['alumnoId'],
              nota: args['nota'],
            );
          },
        '/notas_list': (context){
          final alumnoId = ModalRoute.of(context)!.settings.arguments as int;
          return NotaListCard(alumnoId: alumnoId);
        },
      },
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión Académica'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.school, size: 64, color: Colors.deepPurple),
                const SizedBox(height: 16),
                const Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Seleccione una opción para comenzar',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.people),
                    label: const Text('Alumnos', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AlumnoListPage()),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book),
                    label: const Text('Asignaturas', style: TextStyle(fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.deepPurple.shade200,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AsignaturaListPage()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}