import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/Alumno.dart';
import '../provider/alumnos_privider.dart';

class AlumnoFormPage extends ConsumerStatefulWidget {
  final Alumnos? alumno;


  const AlumnoFormPage({Key? key, this.alumno}) : super(key: key);

  @override
  ConsumerState<AlumnoFormPage> createState() => _AlumnoFormPageState();
}

class _AlumnoFormPageState extends ConsumerState<AlumnoFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreCompletoController;
  late TextEditingController _emailController;
  late TextEditingController _telefonoController;
  late TextEditingController _direccionController;
  late TextEditingController _fechaNacimientoController;


  late TextEditingController _nacionalidadController;

  @override
  void initState() {
    super.initState();
    final alumno = widget.alumno;
    _nombreCompletoController = TextEditingController(text: alumno?.nombreCompleto);
    _emailController = TextEditingController(text: alumno?.email);
    _telefonoController = TextEditingController(text: alumno?.telefono);
    _direccionController = TextEditingController(text: alumno?.direccion);
    _fechaNacimientoController = TextEditingController(text: alumno?.fechaNacimiento);
    _generoSeleccionado = widget.alumno?.genero;
    _estadoCivilSeleccionado = widget.alumno?.estadoCivil;
    _nacionalidadController = TextEditingController(text: alumno?.nacionalidad);
  }

  @override
  void dispose() {
    _nombreCompletoController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    _fechaNacimientoController.dispose();


    _nacionalidadController.dispose();
    super.dispose();
  }

  @override
  String? _estadoCivilSeleccionado;
  final List<String> _estadosCiviles = [
    'Soltero/a',
    'Casado/a',
    'Divorciado/a',
    'Viudo/a',
    'Unión libre',
  ];


  String? _generoSeleccionado;
  final List<String> _generos = [
    'Masculino',
    'Femenino',
    'Otro'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Alumno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nombreCompletoController,
                decoration: const InputDecoration(labelText: 'Nombre Completo'),
                validator: (value) => value!.isEmpty ? 'Ingrese el nombre completo' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Ingrese el email' : null,
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Ingrese el teléfono' : null,
              ),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) => value!.isEmpty ? 'Ingrese la dirección' : null,
              ),
              InkWell(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.tryParse(_fechaNacimientoController.text) ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      _fechaNacimientoController.text = picked.toIso8601String().split('T')[0]; // yyyy-MM-dd
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _fechaNacimientoController,
                    decoration: const InputDecoration(
                      labelText: 'Fecha de Nacimiento',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    validator: (value) => value!.isEmpty ? 'Seleccione la fecha de nacimiento' : null,
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: _generoSeleccionado,
                decoration: const InputDecoration(labelText: 'Género'),
                items: _generos.map((genero) {
                  return DropdownMenuItem(
                    value: genero,
                    child: Text(genero),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _generoSeleccionado = value!;
                  });
                },
                validator: (value) =>
                value == null || value.isEmpty ? 'Seleccione el género' : null,
              ),
              DropdownButtonFormField<String>(
                value: _estadoCivilSeleccionado,
                decoration: const InputDecoration(labelText: 'Estado Civil'),
                items: _estadosCiviles.map((estado) {
                  return DropdownMenuItem(
                    value: estado,
                    child: Text(estado),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _estadoCivilSeleccionado = value!;
                  });
                },
                validator: (value) =>
                value == null || value.isEmpty ? 'Seleccione el estado civil' : null,
              ),

              TextFormField(
                controller: _nacionalidadController,
                decoration: const InputDecoration(labelText: 'Nacionalidad'),
                validator: (value) => value!.isEmpty ? 'Ingrese la nacionalidad' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nuevoAlumno = Alumnos(
                      id: widget.alumno?.id,
                      nombreCompleto: _nombreCompletoController.text,
                      email: _emailController.text,
                      telefono: _telefonoController.text,
                      direccion: _direccionController.text,
                      fechaNacimiento: _fechaNacimientoController.text,
                      genero: _generoSeleccionado ?? '',
                      estadoCivil: _estadoCivilSeleccionado ?? '',
                      nacionalidad: _nacionalidadController.text,
                    );

                    if (widget.alumno == null) {
                      ref.read(alumnosProvider.notifier).addAlumno(nuevoAlumno);
                    } else {
                      ref.read(alumnosProvider.notifier).updateAlumno(nuevoAlumno);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.alumno == null ? 'Crear Alumno' : 'Actualizar Alumno'),
              ),
              if (widget.alumno != null)
                ElevatedButton(
                  onPressed: () {
                    ref.read(alumnosProvider.notifier).deleteAlumno(widget.alumno!.id!);
                    Navigator.pop(context);
                  },
                  child: const Text('Eliminar Alumno'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.close),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
