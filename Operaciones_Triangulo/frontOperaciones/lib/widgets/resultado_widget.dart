import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operacion_viewmodel.dart';

class ResultadoWidget extends StatelessWidget {
  const ResultadoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final resultado = context.watch<OperacionViewModel>().resultado;

    return Center(
      child: Text(
        resultado != null ? "Resultado: $resultado" : "Introduce valores y elige una operación",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
