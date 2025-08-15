import 'package:flutter/material.dart';
import '../viewmodels/operacion_viewmodel.dart';

class ResultWidget extends StatelessWidget {
  final OperacionViewModel viewModel;

  const ResultWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // Mostrar mientras carga
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Mostrar error si ocurre
    if (viewModel.error != null) {
      return Text(
        viewModel.error!,
        style: const TextStyle(color: Colors.red),
      );
    }

    // Mostrar resultado si hay operación
    /*if (viewModel.operacion != null) {
      return Text(
        "Resultado: ${viewModel.operacion!.resultado}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }*/

    // En ResultWidget
    if (viewModel.operacion != null) {
      print("DEBUG RESULTADO: ${viewModel.operacion!.resultado}");
      return Text(
        "Resultado: ${viewModel.operacion!.resultado}",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    }
    // Si no hay nada, retornar vacío
    return const SizedBox.shrink();
  }
}
