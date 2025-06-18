import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/views/pokemon_list_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DDD Pokémon',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: const PokemonListPage(),
    );
  }
}
