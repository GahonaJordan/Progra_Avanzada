class OperacionRequest {
  double numero1;
  double numero2;

  OperacionRequest({required this.numero1, required this.numero2});

  Map<String, dynamic> toJson() {
    return {'numero1': numero1, 'numero2': numero2};
  }
}
