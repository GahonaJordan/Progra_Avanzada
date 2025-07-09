import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Notas.dart';
import '../../domain/entities/Asignatura.dart';
import '../provider/asignaturas_provider.dart';

class NotaTitle extends ConsumerWidget {
  final Notas nota;

  const NotaTitle({super.key, required this.nota});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asignaturas = ref.watch(asignaturasProvider);

    final asignatura = asignaturas.firstWhere(
          (a) => a.id == nota.asignaturaId,
      orElse: () => Asignaturas(
        id: 0,
        nombre: 'Asignatura desconocida',
        descripcion: '',
        creditos: 0,
        semestre: '',
        profesor: '',
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nota: ${nota.valor}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text('Asignatura: ${asignatura.nombre}'),
      ],
    );
  }
}
