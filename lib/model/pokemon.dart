import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

part 'pokemon.g.dart';

@HiveType(typeId: 1)
class Pokemon extends Equatable {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(3)
  final double latitude;

  @HiveField(4)
  final double longitude;

  @HiveField(5)
  final double height;

  @HiveField(6)
  final double weight;

  @HiveField(7)
  final List<String> types;

  @HiveField(8)
  final Map<String, int> stats;

  String get displayName {
    return name.isEmpty ? name : name[0].toUpperCase() + name.substring(1);
  }

  const Pokemon(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.types,
      required this.stats,
      this.latitude = 0,
      this.longitude = 0});

  static double generateRandomCoordinate({double min = -90, double max = 90}) {
    final random = Random();
    return min + random.nextDouble() * (max - min);
  }

  @override
  List<Object> get props => [id, name, height, weight];

  factory Pokemon.fromJson(int index, Map<String, dynamic> json) {
    final int id = json['id'];
    final String name = json['name'];
    final double height = json['height'] / 10;
    final double weight = json['weight'] / 10;
    List<String> types = [];
    Map<String, int> stats = {};

    try {
      types = (json['types'] as List<dynamic>)
          .map((typeData) => typeData['type']['name'] as String)
          .toList();
      stats = (json['stats'] as List<dynamic>).asMap().map((_, statData) =>
          MapEntry(statData['stat']['name'] as String,
              statData['base_stat'] as int));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to parse types and stats: $e');
      }
    }

    return Pokemon(
      id: id,
      name: name,
      height: height,
      weight: weight,
      latitude: generateRandomCoordinate(),
      longitude: generateRandomCoordinate(min: -180, max: 180),
      types: types,
      stats: stats,
    );
  }

  get imageUrl {
    return 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
  }

  get detailImgUrl {
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  }

  factory Pokemon.createNew(
      {required int id,
      required String name,
      required double latitude,
      required double longitude}) {
    return Pokemon(
      id: id,
      name: name,
      height: 0,
      weight: 0,
      types: [],
      stats: {},
      latitude: latitude,
      longitude: longitude,
    );
  }
}
