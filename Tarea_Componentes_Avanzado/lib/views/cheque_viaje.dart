import 'package:flutter/material.dart';

class Ejercicio4 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Ejercicio4State();
}

class Ejercicio4State extends State<Ejercicio4> {
  //Logica
  final TextEditingController diacontroller = TextEditingController();
  final TextEditingController hotelcontroller = TextEditingController();
  final TextEditingController comidacontroller = TextEditingController();
  String resultado = ""; // Texto para mostrar el resultado

  //Metodo
  void calcularMontoCheque() {

    //Declarar variables
    int dias = int.parse(diacontroller.text);
    double hotel = double.parse(hotelcontroller.text);
    double comida = double.parse(comidacontroller.text);
    double gastos = 100; //Gastos diarios

    //Calcular
    //primero verificamos si ingresa un campo vacio
    if (diacontroller.text.isEmpty || hotelcontroller.text.isEmpty || comidacontroller.text.isEmpty) {
      setState(() {
        resultado = "Por favor, ingrese todos los campos.";
      });
      return;
    }

    double totalHotel = hotel * dias;
    double totalComida = comida * dias;
    double totalGastos = gastos * dias;
    double totalCheque = totalHotel + totalComida + totalGastos;

    //Mostrar resultado
    setState(() {
      resultado = "Total del cheque: \$${totalCheque.toStringAsFixed(2)}";
    });

  }

  //Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculo de cheque"),
        backgroundColor: Colors.limeAccent,
        leading: Icon(Icons.check, color: Colors.white),
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
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.check, size: 80, color: Colors.limeAccent),
            SizedBox(height: 20),
            Text(
              "Calculo del monto del cheque para el viaje",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: diacontroller,
              decoration: InputDecoration(
                labelText: "Ingrese el número de días",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: hotelcontroller,
              decoration: InputDecoration(
                labelText: "Ingrese el costo del hotel por día",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: comidacontroller,
              decoration: InputDecoration(
                labelText: "Ingrese el costo de la comida por día",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              "Para los Gastos diarios: \$100",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calcularMontoCheque,
              child: Text("Calcular Monto del Cheque"),
            ),
            SizedBox(height: 20),
            if (resultado.isNotEmpty)
              Center(
                child: Card(
                  elevation: 4, // Sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Bordes redondeados
                  ),
                  color: Colors.limeAccent.shade100, // Color de fondo de la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, // Espaciado horizontal interno
                      vertical: 16.0, // Espaciado vertical interno
                    ),
                    child: Text(
                      resultado,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28, // Ajustamos el tamaño de fuente para adaptarlo mejor
                        fontWeight: FontWeight.bold,
                        color: Colors.limeAccent.shade700, // Color de texto más oscuro
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}