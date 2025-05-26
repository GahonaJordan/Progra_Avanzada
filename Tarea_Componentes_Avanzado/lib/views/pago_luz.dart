import 'package:flutter/material.dart';

class PagoLuz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PagoLuzState();
}

class PagoLuzState extends State<PagoLuz> {
  final TextEditingController kwController = TextEditingController();
  final TextEditingController costoController = TextEditingController();
  String resultado = '';

  void calcularPago() {
    double kw = double.tryParse(kwController.text) ?? 0;
    double costo = double.tryParse(costoController.text) ?? 0;
    double total = kw * costo;

    setState(() {
      resultado = (kw > 0 && costo > 0)
          ? 'Total a pagar: \$${total.toStringAsFixed(2)}'
          : 'Ingresa valores válidos';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text('Pago de Luz y Sombras'),
        backgroundColor: Colors.orange[700],
        leading: Icon(Icons.lightbulb, color: Colors.white),
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
                Icon(Icons.electrical_services, size: 80, color: Colors.orange[400]),
                SizedBox(height: 20),
                Text(
                  'Calcula el pago por consumo eléctrico',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: kwController,
                  decoration: InputDecoration(
                    labelText: 'Kilowatts consumidos',
                    prefixIcon: Icon(Icons.flash_on),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: costoController,
                  decoration: InputDecoration(
                    labelText: 'Costo por kilowatt',
                    prefixIcon: Icon(Icons.attach_money),
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
                  onPressed: calcularPago,
                  icon: Icon(Icons.calculate),
                  label: Text('Calcular pago'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
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
                    color: Colors.orange[100],
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
                          color: Colors.orange[900],
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