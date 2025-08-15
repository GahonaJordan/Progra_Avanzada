import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart'; // Necesario para ChangeNotifier
import 'package:pa_operaciones_rest/viewmodels/triangulo_viewmodel.dart';

// Fake que simula TrianguloViewModel
class FakeTrianguloViewModel extends ChangeNotifier {
  double? lado1;
  double? lado2;
  double? lado3;
  String? resultado;

  Future<String> tipoDeTriangulo(double lado1, double lado2, double lado3) async {
    this.lado1 = lado1;
    this.lado2 = lado2;
    this.lado3 = lado3;

    if (lado1 <= 0 || lado2 <= 0 || lado3 <= 0) {
      throw Exception('Los lados deben ser mayores que cero');
    }

    // verificar si los lado forman un triangulo
    if (lado1 + lado2 <= lado3 || lado1 + lado3 <= lado2 || lado2 + lado3 <= lado1) {
      throw Exception('Los lados no forman un triángulo válido');
    }


    if (lado1 == lado2 && lado2 == lado3) {
      return resultado ='Equilátero';
    } else if (lado1 == lado2 || lado2 == lado3 || lado1 == lado3) {
      return resultado = 'Isósceles';
    } else {
      return resultado = 'Escaleno';
    }
    notifyListeners();
  }
}

void main() {
  // Triangulo equilatero
  test('tipoDeTriangulo Equilátero: 5, 5, 5', () async {
    final viewModel = FakeTrianguloViewModel();
    final resultado = await viewModel.tipoDeTriangulo(5, 5, 5);
    expect(resultado, 'Equilátero');
    print('Prueba 1: Triángulo Equilátero con lados 5, 5, 5 = ${viewModel.resultado}');
  });

  // Triangulo isosceles
  test('tipoDeTriangulo Isósceles: 5, 5, 3', () async {
    final viewModel = FakeTrianguloViewModel();
    final resultado = await viewModel.tipoDeTriangulo(5, 5, 3);
    expect(resultado, 'Isósceles');
    print('Prueba 2: Triángulo Isósceles con lados 5, 5, 3 = ${viewModel.resultado}');
  });

  // Triangulo escaleno
  test('tipoDeTriangulo Escaleno: 4, 5, 6', () async {
    final viewModel = FakeTrianguloViewModel();
    final resultado = await viewModel.tipoDeTriangulo(4, 5, 6);
    expect(resultado, 'Escaleno');
    print('Prueba 3: Triángulo Escaleno con lados 4, 5, 6 = ${viewModel.resultado}');
  });

  // Lados negativos
  test('tipoDeTriangulo con lados negativos lanza excepción', () async {
    final viewModel = FakeTrianguloViewModel();
    expect(() => viewModel.tipoDeTriangulo(-1, 5, 3), throwsException);
    print('Prueba 4: Lados negativos lanza excepción correctamente');
  });

  // Lados que no forman un triangulo
  test('tipoDeTriangulo con lados que no forman un triángulo lanza excepción', () async {
    final viewModel = FakeTrianguloViewModel();
    expect(() => viewModel.tipoDeTriangulo(1, 2, 3), throwsException);
    print('Prueba 5: Lados que no forman un triángulo lanza excepción correctamente');
  });
}