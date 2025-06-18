import 'package:flutter/material.dart';
import '../../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(
          pokemon.imageUrl,
          width: 50,
          errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
        ),
        title: Text(pokemon.name),
        subtitle: Text('Base XP: ${pokemon.baseExperience}'),
      ),
    );
  }
}
