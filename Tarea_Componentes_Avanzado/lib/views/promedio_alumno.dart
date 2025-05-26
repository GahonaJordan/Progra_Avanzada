import 'package:flutter/material.dart';

class PromedioAlumno extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PromedioAlumnoState();
}

class PromedioAlumnoState extends State<PromedioAlumno> {
  final examen1Controller = TextEditingController();
  final examen2Controller = TextEditingController();
  final examen3Controller = TextEditingController();
  String resultado = '';

  void calcularPromedio() {
    double e1 = double.tryParse(examen1Controller.text) ?? 0;
    double e2 = double.tryParse(examen2Controller.text) ?? 0;
    double e3 = double.tryParse(examen3Controller.text) ?? 0;

    double promedio = (e1 * 0.25) + (e2 * 0.25) + (e3 * 0.5);

    setState(() {
      resultado = 'Promedio final: ${promedio.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promedio de Alumno'),
        backgroundColor: Colors.deepPurpleAccent,
        leading: Icon(Icons.school, color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.only(right: 16, left: 8),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(examen1Controller, 'Examen 1'),
              SizedBox(height: 12),
              _buildTextField(examen2Controller, 'Examen 2'),
              SizedBox(height: 12),
              _buildTextField(examen3Controller, 'Examen 3'),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: calcularPromedio,
                icon: Icon(Icons.calculate),
                label: Text('Calcular promedio'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 24),
              if (resultado.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    border: Border.all(color: Colors.deepPurple, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    resultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.school),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
