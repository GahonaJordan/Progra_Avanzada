import 'package:flutter/material.dart';

class PrecioFinal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PrecioFinalState();
}

class PrecioFinalState extends State<PrecioFinal> {
  final TextEditingController precioController = TextEditingController();
  String resultado = '';

  void calcularPrecio() {
    double precio = double.tryParse(precioController.text) ?? 0;
    if (precio <= 0) {
      setState(() {
        resultado = 'Ingresa un valor válido';
      });
      return;
    }
    double precioDescuento = precio * 0.8;
    double precioFinal = precioDescuento * 1.15;

    setState(() {
      resultado =
      'Precio con descuento: \$${precioDescuento.toStringAsFixed(2)}\n'
          'Precio final (con IVA): \$${precioFinal.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Precio final con descuento e IVA'),
        backgroundColor: Colors.green[700],
        leading: Icon(Icons.shopping_cart, color: Colors.white),
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
                Icon(Icons.local_offer, size: 80, color: Colors.green[400]),
                SizedBox(height: 20),
                Text(
                  'Calcula el precio final de un artículo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: precioController,
                  decoration: InputDecoration(
                    labelText: 'Precio original',
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
                  onPressed: calcularPrecio,
                  icon: Icon(Icons.calculate),
                  label: Text('Calcular precio final'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
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
                    color: Colors.green[100],
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(
                        resultado,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
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