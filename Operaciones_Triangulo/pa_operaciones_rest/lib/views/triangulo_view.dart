import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/triangulo_viewmodel.dart';
import '../widgets/result_triangulo_widget.dart';

class TrianguloView extends StatefulWidget {
  const TrianguloView({super.key});

  @override
  State<TrianguloView> createState() => _TrianguloViewState();
}

class _TrianguloViewState extends State<TrianguloView> {
  final TextEditingController lado1Controller = TextEditingController();
  final TextEditingController lado2Controller = TextEditingController();
  final TextEditingController lado3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final trianguloViewModel = Provider.of<TrianguloViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Tipo de Triángulo", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF4A7CFF).withOpacity(0.95),
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3F2FD), Color(0xFF90CAF9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Ingrese los lados del triángulo",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF4A7CFF)),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: lado1Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Lado 1",
                        prefixIcon: Icon(Icons.square_foot),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: lado2Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Lado 2",
                        prefixIcon: Icon(Icons.square_foot),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: lado3Controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Lado 3",
                        prefixIcon: Icon(Icons.square_foot),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A7CFF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        key: const Key("identificar"),
                        onPressed: () {
                          final lado1 = double.tryParse(lado1Controller.text) ?? 0;
                          final lado2 = double.tryParse(lado2Controller.text) ?? 0;
                          final lado3 = double.tryParse(lado3Controller.text) ?? 0;
                          trianguloViewModel.calcular("identificar", lado1, lado2, lado3);
                        },
                        child: const Text(
                          "Calcular Tipo de Triángulo",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ResultTrianguloWidget(trianguloViewModel: trianguloViewModel),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}