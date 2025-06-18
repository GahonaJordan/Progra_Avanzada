import '../../domain/entities/pokemon.dart';
import '../../data/datasource/product_api.dart';


class PokemonRepositoryImpl {
  final PokemonApi api;

  PokemonRepositoryImpl(this.api);

  // Método
  Future<List<Pokemon>> getPokemons({int limit = 10}) =>
      api.fetchPokemons(limit: limit);
}


