import 'package:flutter_test/flutter_test.dart';
import "package:http/http.dart" as http;
import 'package:mockito/mockito.dart';
import 'package:frontoperaciones/viewmodels/operacion_viewmodel.dart';
import '../mocks/mock_client.dart';
import '../mocks/mock_client.mocks.dart';

void main(){
  //define el grupo de pruebas
  group("OperacionViewModel on Mockito", ()

  {
    //se usa para declarar variables
    //palabra reservada
    late MockClient mockClient;
    late OperacionViewModel viewModel;
    
    //incializa el proceso
    //incializar antes de cada test
    
    setUp((){
      mockClient = MockClient();
      viewModel = OperacionViewModel(client: mockClient);
      viewModel.baseUrl="http://localhost:9090/api/calculadora";

      });

    test("Suma: 10 + 5 = 15", () async{
      final uri=Uri.parse("${viewModel.baseUrl}/sumar");
      const fakeResponse = '{"resultado": 15}';

      when (mockClient.post(
        uri,
        headers: anyNamed("headers"),
        body: anyNamed("body"),
      )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      //invocar el resultado oparcion suma
      await viewModel.calcular("suma", 10, 5);
      //validar el resultado
      expect(viewModel.resultado, 15);
      print("Prueba de la suma pasada");


    });
  });
 
}