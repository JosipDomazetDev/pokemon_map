class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  late double latitude;
  late double longitude;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
  });


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final String id = json['id'].toString();
    final String name = json['name'];
    final String imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Pokemon(
      id: int.parse(id),
      name: name,
      imageUrl: imageUrl,
    );
  }
}
