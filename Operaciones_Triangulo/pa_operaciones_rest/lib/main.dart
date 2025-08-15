import 'package:flutter/material.dart';
import 'package:pa_operaciones_rest/views/LoginView.dart';
import 'package:pa_operaciones_rest/views/home_view.dart';
import 'package:pa_operaciones_rest/views/registrar_view.dart';
import 'package:provider/provider.dart';
import 'viewmodels/login_viewmodel.dart';
import 'viewmodels/operacion_viewmodel.dart';
import 'viewmodels/triangulo_viewmodel.dart';
import 'views/LoginView.dart';
import 'views/menu_view.dart';
import 'views/home_view.dart';
import 'views/triangulo_view.dart';
import 'viewmodels/registrar_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => OperacionViewModel()),
        ChangeNotifierProvider(create: (_) => TrianguloViewModel()),
        ChangeNotifierProvider(create: (_) => RegistrarViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora MVVM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/menu': (context) => const MenuView(),
        '/operaciones': (context) => const HomeView(),
        '/triangulo': (context) => const TrianguloView(),
        '/registrar': (context) => const RegistrarNuevo(),
      },
    );
  }
}
