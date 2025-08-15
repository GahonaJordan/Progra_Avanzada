import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart'; // Necesario para ChangeNotifier
import 'package:pa_operaciones_rest/viewmodels/operacion_viewmodel.dart';

// Fake que simula OperacionViewModel esta es la unitaria
class FakeOperacionViewModel extends ChangeNotifier {
  double? resultado;

  Future<void> calcular(String operacion, double numero1, double numero2) async {
    switch (operacion) {
      case 'sumar':
        resultado = numero1 + numero2;
        break;
      case 'restar':
        resultado = numero1 - numero2;
        break;
      case 'multiplicar':
        resultado = numero1 * numero2;
        break;
      case 'dividir':
        resultado = numero2 != 0 ? numero1 / numero2 : null;
        break;
      default:
        resultado = null;
    }
    notifyListeners();
  }
}

void main() {
  //operacion suma
  test('calcular suma: 10 + 5 = 15', () async {
    final viewModel = FakeOperacionViewModel();
    await viewModel.calcular('sumar', 10, 5);
    expect(viewModel.resultado, 15);
    print('Prueba 1: Suma correcta 10 + 5 = ${viewModel.resultado}');
  });

  //operacion resta
  test('calcular resta: 10 - 5 = 5', () async {
    final viewModel = FakeOperacionViewModel();
    await viewModel.calcular('restar', 10, 5);
    expect(viewModel.resultado, 5);
    print('Prueba 2: Resta correcta 10 - 5 = ${viewModel.resultado}');
  });

  //operacion multiplicacion
  test('calcular multiplicación: 10 * 5 = 50', () async {
    final viewModel = FakeOperacionViewModel();
    await viewModel.calcular('multiplicar', 10, 5);
    expect(viewModel.resultado, 50);
    print('Prueba 3: Multiplicación correcta 10 * 5 = ${viewModel.resultado}');
  });

  //operacion division
  test('calcular división: 10 / 5 = 2', () async {
    final viewModel = FakeOperacionViewModel();
    await viewModel.calcular('dividir', 10, 5);
    expect(viewModel.resultado, 2);
    print('Prueba 4: División correcta 10 / 5 = ${viewModel.resultado}');
  });

}
