import 'package:flutter/material.dart';

class AreaCuadrado extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AreaCuadradoState();
}

class AreaCuadradoState extends State<AreaCuadrado> {
  final TextEditingController ladoController = TextEditingController();
  String resultado = '';

  void calcularArea() {
    String entrada = ladoController.text;
    double lado = double.tryParse(entrada) ?? 0;
    double area = lado * lado;

    setState(() {
      resultado = lado > 0 ? 'Área: $area' : 'Ingresa un valor válido';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Área de un cuadrado'),
        backgroundColor: Colors.blue[700],
        leading: Icon(Icons.square_foot, color: Colors.white),
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
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.crop_square, size: 80, color: Colors.blue[400]),
                SizedBox(height: 20),
                Text(
                  'Calcula el área de un cuadrado',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: ladoController,
                  decoration: InputDecoration(
                    labelText: 'Lado del cuadrado',
                    prefixIcon: Icon(Icons.straighten),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: calcularArea,
                  icon: Icon(Icons.calculate),
                  label: Text('Calcular área'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 32),
                if (resultado.isNotEmpty)
                  Card(
                    color: Colors.blue[100],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        resultado,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}