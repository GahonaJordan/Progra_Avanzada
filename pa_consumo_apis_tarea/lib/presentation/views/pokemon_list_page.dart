import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/pokemon_provider.dart';
import '../widgets/pokemon_card.dart';

class PokemonListPage extends ConsumerStatefulWidget {
  const PokemonListPage({super.key});

  @override
  ConsumerState<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends ConsumerState<PokemonListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        ref.read(pokemonListProvider.notifier).loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemons = ref.watch(pokemonListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo Pokémon')),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: pokemons.length,
        itemBuilder: (_, i) => PokemonCard(pokemon: pokemons[i]),
      ),
    );
  }
}
