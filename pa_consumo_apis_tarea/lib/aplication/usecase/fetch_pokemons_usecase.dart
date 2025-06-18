import '../../domain/entities/pokemon.dart';
import '../../data/repositories/pokemon_repository_impl.dart';


class FetchPokemonsUseCase {
  final PokemonRepositoryImpl repositoryImpl;

  FetchPokemonsUseCase(this.repositoryImpl);

  // Método ejecutar
  Future<List<Pokemon>> execute({int limit = 10}) =>
      repositoryImpl.getPokemons(limit: limit);
}
