import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operacion_viewmodel.dart';
import '../widgets/resultado_widget.dart';

class HomeVieww extends StatefulWidget {
  const HomeVieww({super.key});

  @override
  State<HomeVieww> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeVieww> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OperacionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // CABECERA DE BIENVENIDA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFF4285F4),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    "Welcome to Calculator",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Enter two numbers and select an operation",
                    style: TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // CAMPOS DE ENTRADA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    controller: numero1Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número 1",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: numero2Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Número 2",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BOTONES DE OPERACIÓN
            _buildOperacionButton(context, "Sumar", Colors.green, Icons.add, "sumar"),
            _buildOperacionButton(context, "Restar", Colors.blue, Icons.remove, "restar"),
            _buildOperacionButton(context, "Multiplicar", Colors.orange, Icons.close, "multiplicar"),
            _buildOperacionButton(context, "Dividir", Colors.purple, Icons.delete, "dividir"),

            const SizedBox(height: 30),

            // RESULTADO
            const ResultadoWidget(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOperacionButton(BuildContext context, String label, Color color, IconData icon, String operacion) {
    final viewModel = Provider.of<OperacionViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
      child: Card(
        color: Colors.grey.shade100,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          trailing: ElevatedButton(
            onPressed: () {
              double n1 = double.tryParse(numero1Controller.text) ?? 0;
              double n2 = double.tryParse(numero2Controller.text) ?? 0;
              viewModel.calcular(operacion, n1, n2);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Calcular"),
          ),
        ),
      ),
    );
  }
}
