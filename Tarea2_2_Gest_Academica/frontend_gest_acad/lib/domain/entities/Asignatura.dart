class Asignaturas{
  int? id;
  String nombre;
  String descripcion;
  int creditos;
  String semestre;
  String profesor;

  // Constructor
  Asignaturas({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.creditos,
    required this.semestre,
    required this.profesor,
  });

  // Factory
  factory Asignaturas.fromJson(Map<String, dynamic> json) {
    return Asignaturas(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      creditos: json['creditos'],
      semestre: json['semestre'],
      profesor: json['profesor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'creditos': creditos,
      'semestre': semestre,
      'profesor': profesor,
    };
  }
}