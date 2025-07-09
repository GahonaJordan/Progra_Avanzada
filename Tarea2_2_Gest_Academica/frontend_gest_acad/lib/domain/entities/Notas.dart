class Notas{
  int? id;
  double valor;
  int alumnoId;
  int asignaturaId;

  // Constructor
  Notas({
    this.id,
    required this.valor,
    required this.alumnoId,
    required this.asignaturaId,
  });

  // Factory
  factory Notas.fromJson(Map<String, dynamic> json) {
    return Notas(
      id: json['id'],
      valor: json['valor'],
      alumnoId: json['alumnoId'],
      asignaturaId: json['asignaturaId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valor': valor,
      'alumnoId': alumnoId,
      'asignaturaId': asignaturaId,
    };
  }
}