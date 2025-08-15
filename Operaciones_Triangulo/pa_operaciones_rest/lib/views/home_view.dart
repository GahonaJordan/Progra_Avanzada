import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/operacion_viewmodel.dart';
import '../widgets/result_widget.dart';

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
      appBar: AppBar(
        title: const Text("Operaciones Básicas"),
        backgroundColor: const Color(0xFF4A7CFF),
      ),
      backgroundColor: const Color(0xFF4A7CFF), // azul fondo superior
      body: SafeArea(
        child: Column(
          children: [
            // Encabezado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Calculator",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Enter two numbers and select an operation",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Panel inferior
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  children: [
                    TextField(
                      controller: numero1Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Número 1"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: numero2Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Número 2"),
                    ),
                    const SizedBox(height: 20),

                    // Tarjetas de operaciones
                    OperationCard(
                      key: ValueKey('sumarButton'),
                      icon: Icons.add,
                      color: Colors.green,
                      label: "Sumar",
                      onTap: () {
                        final num1 = double.tryParse(numero1Controller.text) ?? 0;
                        final num2 = double.tryParse(numero2Controller.text) ?? 0;
                        viewModel.calcular("sumar", num1, num2);
                      },
                    ),
                    OperationCard(
                      key: ValueKey('restarButton'),
                      icon: Icons.remove,
                      color: Colors.blue,
                      label: "Restar",
                      onTap: () {
                        final num1 = double.tryParse(numero1Controller.text) ?? 0;
                        final num2 = double.tryParse(numero2Controller.text) ?? 0;
                        viewModel.calcular("restar", num1, num2);
                      },
                    ),
                    OperationCard(
                      key: ValueKey('multiplicarButton'),
                      icon: Icons.close,
                      color: Colors.orange,
                      label: "Multiplicar",
                      onTap: () {
                        final num1 = double.tryParse(numero1Controller.text) ?? 0;
                        final num2 = double.tryParse(numero2Controller.text) ?? 0;
                        viewModel.calcular("multiplicar", num1, num2);
                      },
                    ),
                    OperationCard(
                      key: ValueKey('dividirButton'),
                      icon: Icons.delete,
                      color: Colors.purple,
                      label: "Dividir",
                      onTap: () {
                        final num1 = double.tryParse(numero1Controller.text) ?? 0;
                        final num2 = double.tryParse(numero2Controller.text) ?? 0;
                        viewModel.calcular("dividir", num1, num2);
                      },
                    ),
                    const SizedBox(height: 20),
                    ResultWidget(viewModel: viewModel),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const OperationCard({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: ElevatedButton(
          key: ValueKey('${label.toLowerCase()}Button'),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: onTap,
          child: const Text("Calcular"),
        ),
      ),
    );
  }
}
