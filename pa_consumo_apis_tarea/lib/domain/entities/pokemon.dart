class Pokemon {
  final String title; // Usaremos el nombre como título
  final int experienciaBase;
  final String image; // Usaremos el audio "cry"
  final String habilidadPrincipal;
  final String imageUrl;
  final String name;
  final int baseExperience;

  Pokemon({
    required this.title,
    required this.experienciaBase,
    required this.image,
    required this.habilidadPrincipal,
    required this.imageUrl,
    required this.name,
    required this.baseExperience,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final habilidades = json['abilities'] as List;
    final habilidadPrincipal = habilidades.isNotEmpty
        ? habilidades[0]['ability']['name']
        : 'Desconocida';

    return Pokemon(
      title: json['name'], // no viene "formas" en esta ruta
      experienciaBase: json['base_experience'],
      image: 'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/${json['id']}.ogg',
      habilidadPrincipal: habilidadPrincipal,
      imageUrl: json['sprites']['front_default'],
      name: json['name'],
      baseExperience: json['base_experience'],
    );
  }
}
