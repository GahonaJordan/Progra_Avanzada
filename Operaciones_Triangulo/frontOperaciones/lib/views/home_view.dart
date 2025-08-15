import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operacion_viewmodel.dart';
import '../widgets/resultado_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OperacionViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.blue.shade700,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            const Text("Welcome to Calculator", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
            const Text("Enter two numbers and select an operation", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 30),
            TextField(
              controller: numero1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Número 1", border: UnderlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numero2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Número 2", border: UnderlineInputBorder()),
            ),
            const SizedBox(height: 24),
            _buildOperacionButton(context, "Sumar", Colors.green, Icons.add, "sumar"),
            _buildOperacionButton(context, "Restar", Colors.blue, Icons.remove, "restar"),
            _buildOperacionButton(context, "Multiplicar", Colors.orange, Icons.clear, "multiplicar"),
            _buildOperacionButton(context, "Dividir", Colors.purple, Icons.delete, "dividir"),
            const SizedBox(height: 24),
            const ResultadoWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildOperacionButton(BuildContext context, String label, Color color, IconData icon, String operacion) {
    final viewModel = Provider.of<OperacionViewModel>(context, listen: false);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade100,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: ElevatedButton(
          onPressed: () {
            double n1 = double.tryParse(numero1Controller.text) ?? 0;
            double n2 = double.tryParse(numero2Controller.text) ?? 0;
            viewModel.calcular(operacion, n1, n2);
          },
          style: ElevatedButton.styleFrom(backgroundColor: color),
          child: const Text("Calcular"),
        ),
      ),
    );
  }
}
