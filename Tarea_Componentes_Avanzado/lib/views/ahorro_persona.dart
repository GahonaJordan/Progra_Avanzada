import 'package:flutter/material.dart';

class Ejercicio3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Ejercicio3State();
}

class Ejercicio3State extends State<Ejercicio3> {
  // Lógica
  final TextEditingController controller = TextEditingController();
  String resultado = ""; // Texto para mostrar el resultado
  String tipoSueldo = "Semanal"; // Tipo de sueldo inicial (coincide con el Dropdown)

  // Método
  void ahoraaPersona() {
    // Declarar variables
    String entrada = controller.text;
    double sueldoSemanal;
    double porcentajeAhorro = 0.15; // 15%
    int semanasEnAnio = 4 * 12; // 4 semanas por mes * 12 meses

    if (entrada.isEmpty) {
      setState(() {
        resultado = "Por favor, ingrese un sueldo.";
      });
      return;
    }

    try {
      double sueldo = double.parse(entrada);

      if (tipoSueldo == "Semanal") {
        sueldoSemanal = sueldo;
      } else {
        sueldoSemanal = sueldo / 4; // Convertir a semanal
      }

      // Calcular
      double ahorroSemanal = sueldoSemanal * porcentajeAhorro;
      double ahorroAnual = ahorroSemanal * semanasEnAnio;

      // Mostrar resultado
      setState(() {
        resultado =
        "Ahorro semanal: \$${ahorroSemanal.toStringAsFixed(2)}\nAhorro anual: \$${ahorroAnual.toStringAsFixed(2)}";
      });
    } catch (e) {
      setState(() {
        resultado = "Por favor, ingrese un número válido.";
      });
    }
  }

  // Diseño
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ahorro semanal y anual"),
        backgroundColor: Colors.green[700],
        leading: Icon(Icons.savings, color: Colors.white),
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
            Icon(Icons.savings, size: 80, color: Colors.green[400]),
            SizedBox(height: 20),
            Text(
              "Calcula tu ahorro semanal y anual",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[900],
              ),
              textAlign: TextAlign.center,
            ),
            DropdownButton<String>(
              value: tipoSueldo,
              items: [
                DropdownMenuItem(
                  value: "Semanal",
                  child: Text("Sueldo Semanal"),
                ),
                DropdownMenuItem(
                  value: "Mensual",
                  child: Text("Sueldo Mensual"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  tipoSueldo = value!;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Ingrese su sueldo",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ahoraaPersona,
              child: Text("Calcular Ahorro"),
            ),
            SizedBox(height: 20),
            if (resultado.isNotEmpty)
            Card(
              elevation: 4, // Sombra
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Bordes redondeados
              ),
              color: Colors.green[50], // Color de fondo de la tarjeta
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Espaciado interno
                child: Text(
                  resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[900],
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
