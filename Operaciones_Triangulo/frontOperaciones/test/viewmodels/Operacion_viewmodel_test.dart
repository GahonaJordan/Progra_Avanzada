import "package:flutter_test/flutter_test.dart";
import 'package:frontoperaciones/viewmodels/operacion_viewmodel.dart';

// ViewModel para pruebas sin backend
class FakeOperacionViewModel extends OperacionViewModel {
  Future<void> calcular(String operacion, double numero1, double numero2) async {
    switch (operacion) {
      case "sumar":
        resultado = numero1 + numero2;
        break;
      case "restar":
        resultado = numero1 - numero2;
        break;
      case "multiplicar":
        resultado = numero1 * numero2;
        break;
      case "dividir":
        resultado = numero2 != 0 ? numero1 / numero2 : null;
        break;
      default:
        resultado = null;
    }
    notifyListeners();
  }
}

void main() {
  group("Pruebas de operaciones matemáticas", () {
    late FakeOperacionViewModel viewModel;

    setUp(() {
      viewModel = FakeOperacionViewModel();
    });

    test("Sumar: 10 + 5 = 15", () async {
      await viewModel.calcular("sumar", 10, 5);
      print("Prueba de suma: 10 + 5 = ${viewModel.resultado}");
      expect(viewModel.resultado, 15);
    });

    test("Restar: 10 - 5 = 5", () async {
      await viewModel.calcular("restar", 10, 5);
      print("Prueba de resta: 10 - 5 = ${viewModel.resultado}");
      expect(viewModel.resultado, 5);
    });

    test("Multiplicar: 10 * 5 = 50", () async {
      await viewModel.calcular("multiplicar", 10, 5);
      print("Prueba de multiplicación: 10 * 5 = ${viewModel.resultado}");
      expect(viewModel.resultado, 50);
    });

    test("Dividir: 10 / 5 = 2", () async {
      await viewModel.calcular("dividir", 10, 5);
      print("Prueba de división: 10 / 5 = ${viewModel.resultado}");
      expect(viewModel.resultado, 2);
    });

    test("División por cero: 10 / 0 = null", () async {
      await viewModel.calcular("dividir", 10, 0);
      print("Prueba de división por cero: 10 / 0 = ${viewModel.resultado}");
      expect(viewModel.resultado, null);
    });
  });
}
