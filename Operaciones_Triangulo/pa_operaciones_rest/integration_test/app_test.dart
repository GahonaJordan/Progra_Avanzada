import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pa_operaciones_rest/main.dart' as app;
import 'package:flutter/material.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  //test para iniciar sesion
  testWidgets('Iniciar sesión exitoso', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final userField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Usuario');
    final passField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Contraseña');
    final loginButton = find.widgetWithText(ElevatedButton, 'Iniciar Sesión');

    await tester.enterText(userField, 'jordan');
    await tester.enterText(passField, '123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verifica que navega al menú principal
    expect(find.text('Menú Principal'), findsOneWidget);
  });

  testWidgets('Iniciar sesión fallido', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final userField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Usuario');
    final passField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Contraseña');
    final loginButton = find.widgetWithText(ElevatedButton, 'Iniciar Sesión');

    await tester.enterText(userField, 'usuario_incorrecto');
    await tester.enterText(passField, 'contraseña_incorrecta');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verifica que se muestra el mensaje de error correcto
    expect(find.text('Credenciales incorrectas'), findsOneWidget);
  });

  //test para ir a operaciones basicas y realizar las operaciones
  testWidgets('Ir a operaciones básicas', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Login primero
    final userField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Usuario');
    final passField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Contraseña');
    final loginButton = find.widgetWithText(ElevatedButton, 'Iniciar Sesión');
    await tester.enterText(userField, 'jordan');
    await tester.enterText(passField, '123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Ir a operaciones básicas
    final operacionesButton = find.text('Operaciones Básicas');
    expect(operacionesButton, findsOneWidget);
    await tester.tap(operacionesButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));


    // Encuentra los campos de operación
    final numero1Field = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Número 1');
    final numero2Field = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Número 2');

    // Verifica que los campos están presentes
    expect(numero1Field, findsOneWidget);
    expect(numero2Field, findsOneWidget);

    // Ingresa números
    await tester.enterText(numero1Field, '10');
    await tester.enterText(numero2Field, '5');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Realiza una suma
    final sumarCard = find.byKey(ValueKey('sumarButton'));
    final sumarButton = find.descendant(
      of: sumarCard,
      matching: find.byType(ElevatedButton),
    );
    await tester.tap(sumarButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verifica el resultado
    expect(find.text('Resultado: 15.0'), findsOneWidget);

    // Realiza una resta
    final restarCard = find.byKey(ValueKey('restarButton'));
    final restarButton = find.descendant(
      of: restarCard,
      matching: find.byType(ElevatedButton),
    );
    await tester.tap(restarButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verifica el resultado
    expect(find.text('Resultado: 5.0'), findsOneWidget);

    // Realiza una multiplicación
    final multiplicarCard = find.byKey(ValueKey('multiplicarButton'));
    final multiplicarButton = find.descendant(
      of: multiplicarCard,
      matching: find.byType(ElevatedButton),
    );
    await tester.tap(multiplicarButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verifica el resultado
    expect(find.text('Resultado: 50.0'), findsOneWidget);

    // Realiza una división
    final dividirCard = find.byKey(ValueKey('dividirButton'));
    final dividirButton = find.descendant(
      of: dividirCard,
      matching: find.byType(ElevatedButton),
    );
    await tester.tap(dividirButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verifica el resultado
    expect(find.text('Resultado: 2.0'), findsOneWidget);

    // Verificar la división por cero
    // Forzamos tap para enfocar y borrar el campo Número 2
    await tester.tap(numero2Field);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Cambiamos el segundo número a 0 borramos el campo
    await tester.enterText(numero2Field, '');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    //ingresamos 0
    await tester.enterText(numero2Field, '0');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Forzamos unfocus para que se procese el cambio
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // Volvemos a presionar el botón de dividir
    await tester.tap(dividirButton);
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verifica que se muestra un mensaje de error
    expect(find.text('Error: 401'), findsOneWidget);

    // Regresar al menú principal
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));


    // Cerrar sesión
    final logoutButton = find.byIcon(Icons.logout);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Confirmamos que volvió al login
    expect(find.text('Bienvenido'), findsOneWidget);


  });

  //test para ir a operaciones de triángulo y verificar el tipo de triángulo
  testWidgets('Ir a operaciones de triángulo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Login primero
    final userField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Usuario');
    final passField = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Contraseña');
    final loginButton = find.widgetWithText(ElevatedButton, 'Iniciar Sesión');
    await tester.enterText(userField, 'jordan');
    await tester.enterText(passField, '123');
    await tester.tap(loginButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Ir a Tipo de Triángulo
    final trianguloButton = find.text('Tipo de Triángulo');
    expect(trianguloButton, findsOneWidget);
    await tester.tap(trianguloButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Encuentra los campos de triángulo
    final lado1Field = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Lado 1');
    final lado2Field = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Lado 2');
    final lado3Field = find.byWidgetPredicate((widget) =>
    widget is TextField && widget.decoration?.labelText == 'Lado 3');

    // Verifica que los campos están presentes
    expect(lado1Field, findsOneWidget);
    expect(lado2Field, findsOneWidget);
    expect(lado3Field, findsOneWidget);

    // Ingresa lados del triángulo para escaleno
    await tester.enterText(lado1Field, '3');
    await tester.enterText(lado2Field, '4');
    await tester.enterText(lado3Field, '5');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Presiona el botón para verificar el tipo de triángulo
    final verificarButton = find.byKey(ValueKey('identificar'));
    await tester.tap(verificarButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Verifica el resultado
    expect(find.text('Resultado: El triángulo es escaleno.'), findsOneWidget);

    // Ingresa lados del triángulo para isósceles
    await tester.enterText(lado1Field, '5');
    await tester.enterText(lado2Field, '5');
    await tester.enterText(lado3Field, '8');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Presiona el botón para verificar el tipo de triángulo
    await tester.tap(verificarButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verifica el resultado
    expect(find.text('Resultado: El triángulo es isósceles.'), findsOneWidget);

    // Ingresa lados del triángulo para equilátero
    await tester.enterText(lado1Field, '6');
    await tester.enterText(lado2Field, '6');
    await tester.enterText(lado3Field, '6');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Presiona el botón para verificar el tipo de triángulo
    await tester.tap(verificarButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verifica el resultado
    expect(find.text('Resultado: El triángulo es equilátero.'), findsOneWidget);

    // Ingresa lados del triángulo para no válido
    await tester.enterText(lado1Field, '1');
    await tester.enterText(lado2Field, '2');
    await tester.enterText(lado3Field, '3');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Presiona el botón para verificar el tipo de triángulo
    await tester.tap(verificarButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verifica el resultado
    expect(find.text('Resultado: No es un triángulo válido'), findsOneWidget);

    // Regresar al menú principal
    final backButton = find.byIcon(Icons.arrow_back);
    await tester.tap(backButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));


    // Cerrar sesión
    final logoutButton = find.byIcon(Icons.logout);
    await tester.tap(logoutButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Confirmamos que volvió al login
    expect(find.text('Bienvenido'), findsOneWidget);

  });

}