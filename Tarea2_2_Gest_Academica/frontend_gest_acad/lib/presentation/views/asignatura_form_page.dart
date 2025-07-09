import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Asignatura.dart';
import '../provider/asignaturas_provider.dart';

class AsignaturaFormPage extends ConsumerStatefulWidget {
  final Asignaturas? asignatura;

  const AsignaturaFormPage({Key? key, this.asignatura}) : super(key: key);

  @override
  ConsumerState<AsignaturaFormPage> createState() => _AsignaturaFormPageState();
}

class _AsignaturaFormPageState extends ConsumerState<AsignaturaFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _creditosController;
  late TextEditingController _semestreController;
  late TextEditingController _profesorController;

  @override
  void initState() {
    super.initState();
    final a = widget.asignatura;
    _nombreController = TextEditingController(text: a?.nombre);
    _descripcionController = TextEditingController(text: a?.descripcion);
    _creditosController = TextEditingController(text: a?.creditos.toString());
    _semestreController = TextEditingController(text: a?.semestre);
    _profesorController = TextEditingController(text: a?.profesor);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _creditosController.dispose();
    _semestreController.dispose();
    _profesorController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate()) {
      final nuevaAsignatura = Asignaturas(
        id: widget.asignatura?.id,
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        creditos: int.tryParse(_creditosController.text) ?? 0,
        semestre: _semestreController.text,
        profesor: _profesorController.text,
      );

      if (widget.asignatura == null) {
        ref.read(asignaturasProvider.notifier).addAsignatura(nuevaAsignatura);
      } else {
        ref.read(asignaturasProvider.notifier).updateAsignatura(nuevaAsignatura);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Asignatura'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Ingrese nombre' : null,
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (v) => v!.isEmpty ? 'Ingrese descripción' : null,
              ),
              TextFormField(
                controller: _creditosController,
                decoration: const InputDecoration(labelText: 'Créditos'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Ingrese créditos' : null,
              ),
              TextFormField(
                controller: _semestreController,
                decoration: const InputDecoration(labelText: 'Semestre'),
                validator: (v) => v!.isEmpty ? 'Ingrese semestre' : null,
              ),
              TextFormField(
                controller: _profesorController,
                decoration: const InputDecoration(labelText: 'Profesor'),
                validator: (v) => v!.isEmpty ? 'Ingrese profesor' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardar,
                child: Text(widget.asignatura == null ? 'Crear' : 'Actualizar'),
              ),
              if (widget.asignatura != null)
                ElevatedButton(
                  onPressed: () {
                    ref.read(asignaturasProvider.notifier).deleteAsignatura(widget.asignatura!.id!);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Eliminar'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}