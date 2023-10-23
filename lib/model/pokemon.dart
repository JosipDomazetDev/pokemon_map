import 'dart:math';

import 'package:hive/hive.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(3)
  double latitude;

  @HiveField(4)
  double longitude;

  String get displayName {
    return name.isEmpty ? name : name[0].toUpperCase() + name.substring(1);
  }

  Pokemon(
      {required this.id,
      required this.name,
      this.latitude = 0,
      this.longitude = 0});

  static double generateRandomCoordinate({double min = -90, double max = 90}) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  factory Pokemon.fromJson(int index, Map<String, dynamic> json) {
    final String id = (index + 1).toString();
    final String name = json['name'];

    return Pokemon(
      id: int.parse(id),
      name: name,
      latitude: generateRandomCoordinate(),
      longitude: generateRandomCoordinate(min: -180, max: 180),
    );
  }

  get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  get detailImgUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$id.svg';
  }
}
