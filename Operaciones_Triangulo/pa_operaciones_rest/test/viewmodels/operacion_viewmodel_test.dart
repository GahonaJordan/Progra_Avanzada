import 'package:flutter_test/flutter_test.dart';
import 'package:pa_operaciones_rest/viewmodels/operacion_viewmodel.dart';

void main(){
  group('OperacionViewModel', (){
    late OperacionViewModel viewModel;
    setUp(() {
      viewModel = OperacionViewModel();
    });
    test('inicia de forma correcta', () {
      expect(viewModel.operacion, isNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 1: Estado inicial correcto');
    });

    //prueba a las operaciones
    test('calcular suma', () async {
      await viewModel.calcular('sumar', 5, 3);
      expect(viewModel.operacion?.resultado, 8);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 2: Suma correcta');
    });

    test('calcular resta', () async {
      await viewModel.calcular('restar', 5, 3);
      expect(viewModel.operacion?.resultado, 2);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 3: Resta correcta');
    });

    test('calcular multiplicacion', () async {
      await viewModel.calcular('multiplicar', 5, 3);
      expect(viewModel.operacion?.resultado, 15);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 4: Multiplicación correcta');
    });

    test('calcular division', () async {
      await viewModel.calcular('dividir', 6, 3);
      expect(viewModel.operacion?.resultado, 2);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 5: División correcta');
    });
  });
}