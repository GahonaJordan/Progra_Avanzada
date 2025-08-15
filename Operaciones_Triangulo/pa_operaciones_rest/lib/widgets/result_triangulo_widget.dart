import 'package:flutter/material.dart';
import '../viewmodels/triangulo_viewmodel.dart';

class ResultTrianguloWidget extends StatelessWidget{
  final TrianguloViewModel trianguloViewModel;

  const ResultTrianguloWidget({super.key, required this.trianguloViewModel});

  @override
  Widget build(BuildContext context) {
    // Mostrar mientras carga
    if (trianguloViewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Mostrar error si ocurre
    if (trianguloViewModel.error != null) {
      return Text(
        trianguloViewModel.error!,
        style: const TextStyle(color: Colors.red),
      );
    }

    // Mostrar resultado si hay operación
    /*if (trianguloViewModel.triangulo != null) {
      return Text(
        "Resultado: ${trianguloViewModel.triangulo!.resultado}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }*/
    if (trianguloViewModel.triangulo != null) {
      print("DEBUG RESULTADO: ${trianguloViewModel.triangulo!.resultado}");
      return Text(
        "Resultado: ${trianguloViewModel.triangulo!.resultado}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }

    // Si no hay nada, retornar vacío
    return const SizedBox.shrink();
  }

}