import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:pa_operaciones_rest/viewmodels/operacion_viewmodel.dart';
import '../mocks/mock_client.dart';
import '../mocks/mock_client.mocks.dart';

void main(){
  // defino el grupo de pruebas
  group('OperacionViewModel con mokito', ()
  {
    //se usa MockClient para simular el cliente HTTP
    //para declarar las variables
    //palabra reservada late para declarar variables que se inicializarán más tarde
    late MockClient mockClient;
    late OperacionViewModel viewModel;

    // inicializo las variables para el proceso de pruebas
    setUp(() {
      mockClient = MockClient();
      viewModel = OperacionViewModel(client: mockClient);
      viewModel.baseUrl = 'http://localhost:9090/api/calculadora';
    });

    test('Suma: 10 + 5 = 15', () async {
      final uri = Uri.parse('${viewModel.baseUrl}/sumar');
      const fakeResponse = '{"resultado": 15}';

      //simulando la respuesta del cliente HTTP
      when(mockClient.post(
        uri,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      //invoca el resultado de la operación
      await viewModel.calcular('sumar', 10, 5);
      //valida el resultado de la operación
      expect(viewModel.operacion?.resultado, 15);
      print('Prueba de la suma pasada');
    });

  });

}
