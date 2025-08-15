import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:pa_operaciones_rest/viewmodels/login_viewmodel.dart';

// Fake que simula LoginViewModel
class FakeLoginViewModel extends ChangeNotifier{
  String? username;
  String? password;
  bool isLoading = false;
  String? error;

  Future<void> login(String username, String password) async {
    isLoading = true;
    notifyListeners();

    // Simula una llamada a un servicio de autenticación
    await Future.delayed(Duration(seconds: 1));

    if (username == 'jordan' && password == '123') {
      this.username = username;
      this.password = password;
      error = null;
    } else {
      error = 'Credenciales inválidas';
    }

    isLoading = false;
    notifyListeners();
  }
}

void main() {
  group('LoginViewModel', () {
    late FakeLoginViewModel viewModel;

    setUp(() {
      viewModel = FakeLoginViewModel();
    });

    test('inicia de forma correcta', () {
      expect(viewModel.username, isNull);
      expect(viewModel.password, isNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 1: Estado inicial correcto');
    });

    test('login exitoso', () async {
      await viewModel.login('jordan', '123');
      expect(viewModel.username, 'jordan');
      expect(viewModel.password, '123');
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);

      print('Prueba 2: Login exitoso');
    });

    test('login fallido', () async {
      await viewModel.login('test', 'wrongpassword');
      expect(viewModel.username, isNull);
      expect(viewModel.password, isNull);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, 'Credenciales inválidas');

      print('Prueba 3: Login fallido');
    });
  });
}