import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/product_api.dart';
import '../../domain/entities/pokemon.dart';
import '../../data/repositories/pokemon_repository_impl.dart';
import '../../aplication/usecase/fetch_pokemons_usecase.dart';

final _api = PokemonApi();
final _repository = PokemonRepositoryImpl(_api);
final _useCase = FetchPokemonsUseCase(_repository);

class PokemonListNotifier extends StateNotifier<List<Pokemon>> {
  PokemonListNotifier() : super([]) {
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    final pokemons = await _useCase.execute(limit: 10);
    state = pokemons;
  }

  Future<void> loadMore() async {
    final more = await _useCase.execute(limit: 10);
    state = [...state, ...more];
  }
}

final pokemonListProvider =
StateNotifierProvider<PokemonListNotifier, List<Pokemon>>(
      (ref) => PokemonListNotifier(),
);
