import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/pokemon.dart';


class PokemonApi {
  final baseUrl = 'https://pokeapi.co/api/v2';

  // Método fetch
  Future<List<Pokemon>> fetchPokemons({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=$limit'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results']; // lista de Pokémon básicos

      // Obtener el detalle de cada uno (para usar la clase Pokemon)
      final pokemons = <Pokemon>[];

      for (var result in results) {
        final detailResponse = await http.get(Uri.parse(result['url']));
        if (detailResponse.statusCode == 200) {
          final detailData = json.decode(detailResponse.body);
          pokemons.add(Pokemon.fromJson(detailData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Error al cargar los pokemones');
    }
  }
}
