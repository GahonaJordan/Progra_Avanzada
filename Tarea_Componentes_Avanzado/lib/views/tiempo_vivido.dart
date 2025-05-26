import 'package:flutter/material.dart';

class TiempoVivido extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TiempoVividoState();
}

class TiempoVividoState extends State<TiempoVivido> {
  final edadController = TextEditingController();
  String resultado = '';

  void calcularTiempo() {
    int edad = int.tryParse(edadController.text) ?? 0;
    int meses = edad * 12;
    int semanas = edad * 52;
    int dias = edad * 365;
    int horas = dias * 24;

    setState(() {
      resultado =
      'Meses: $meses\nSemanas: $semanas\nDías: $dias\nHoras: $horas';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiempo vivido"),
        backgroundColor: Colors.pinkAccent,
        leading: Icon(Icons.access_time, color: Colors.white),
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
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: edadController,
                  decoration: InputDecoration(
                    labelText: 'Edad en años',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.cake),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: calcularTiempo,
                  icon: Icon(Icons.calculate),
                  label: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                if (resultado.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.pinkAccent, width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      resultado,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
