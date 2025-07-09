import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Notas.dart';
import '../../domain/entities/asignatura.dart';
import '../provider/notas_provider.dart';
import '../provider/asignaturas_provider.dart';

class NotaFormPage extends ConsumerStatefulWidget {
  final int alumnoId;
  final Notas? nota;

  const NotaFormPage({Key? key, required this.alumnoId, this.nota}) : super(key: key);

  @override
  ConsumerState<NotaFormPage> createState() => _NotaFormPageState();
}

class _NotaFormPageState extends ConsumerState<NotaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _valorController;
  int? _selectedAsignaturaId;

  @override
  void initState() {
    super.initState();
    final nota = widget.nota;
    _valorController = TextEditingController(text: nota?.valor.toString());
    _selectedAsignaturaId = nota?.asignaturaId;
  }

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate() && _selectedAsignaturaId != null) {
      final nuevaNota = Notas(
        id: widget.nota?.id,
        valor: double.tryParse(_valorController.text) ?? 0.0,
        alumnoId: widget.alumnoId, // ya viene desde la pantalla anterior
        asignaturaId: _selectedAsignaturaId!,
      );

      if (widget.nota == null) {
        ref.read(notasProvider.notifier).addNota(nuevaNota);
      } else {
        ref.read(notasProvider.notifier).updateNota(nuevaNota);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asignaturas = ref.watch(asignaturasProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nota == null ? 'Crear Nota' : 'Editar Nota'),
      ),
      body: asignaturas.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor de la nota'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Ingrese el valor de la nota' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedAsignaturaId,
                items: asignaturas.map((a) {
                  return DropdownMenuItem<int>(
                    value: a.id,
                    child: Text(a.nombre),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAsignaturaId = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Asignatura'),
                validator: (value) => value == null ? 'Seleccione una asignatura' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                child: Text(widget.nota == null ? 'Crear Nota' : 'Actualizar Nota'),
              ),
              if (widget.nota != null)
                ElevatedButton(
                  onPressed: () {
                    ref.read(notasProvider.notifier).deleteNota(widget.nota!.id!);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Eliminar Nota'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
