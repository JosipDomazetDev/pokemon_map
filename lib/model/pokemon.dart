import 'dart:math';

class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  late double latitude;
  late double longitude;

  String get displayName {
    return name.isEmpty ? name : name[0].toUpperCase() + name.substring(1);
  }

  Pokemon(
      {required this.id,
      required this.name,
      required this.imageUrl,
      this.latitude = 0,
      this.longitude = 0});

  static double generateRandomCoordinate({double min = -90, double max = 90}) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final String id = json['id'].toString();
    final String name = json['name'];
    final String imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Pokemon(
      id: int.parse(id),
      name: name,
      imageUrl: imageUrl,
      latitude: generateRandomCoordinate(),
      longitude: generateRandomCoordinate(),
    );
  }
}
