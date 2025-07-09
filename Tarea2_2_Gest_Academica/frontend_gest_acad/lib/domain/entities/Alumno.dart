import 'Notas.dart';

class Alumnos{
  int? id;
  String nombreCompleto;
  String email;
  String telefono;
  String direccion;
  String fechaNacimiento;
  String genero;
  String estadoCivil;
  String nacionalidad;
  List<Notas>? notas;

  // Constructor
  Alumnos({
    this.id,
    required this.nombreCompleto,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.fechaNacimiento,
    required this.genero,
    required this.estadoCivil,
    required this.nacionalidad,
    this.notas});

    //Factory
  factory Alumnos.fromJson(Map<String, dynamic> json) {
    return Alumnos(
      id: json['id'],
      nombreCompleto: json['nombreCompleto'],
      email: json['email'],
      telefono: json['telefono'],
      direccion: json['direccion'],
      fechaNacimiento: json['fechaNacimiento'],
      genero: json['genero'],
      estadoCivil: json['estadoCivil'],
      nacionalidad: json['nacionalidad'],
      notas: (json['notas'] as List?)?.map((e) => Notas.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombreCompleto': nombreCompleto,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'fechaNacimiento': fechaNacimiento,
      'genero': genero,
      'estadoCivil': estadoCivil,
      'nacionalidad': nacionalidad,
      'notas': notas?.map((e) => e.toJson()).toList(),
    };
  }



}