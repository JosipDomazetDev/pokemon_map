import 'package:flutter/material.dart';
import 'package:pokemon_map/screens/widgets/type_chip.dart';

import '../model/pokemon.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailScreen({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.displayName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInImage.assetNetwork(
                  fadeInDuration: const Duration(milliseconds: 100),
                  fadeOutDuration: const Duration(milliseconds: 100),
                  image: pokemon.detailImgUrl,
                  placeholder: 'assets/pokeball.png',
                  width: 250,
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Column(
                      children: [
                        Image.asset(
                          'assets/pokeball.png',
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(height: 100),
                      ],
                    );
                  }),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    pokemon.types.map((type) => _buildTypeChip(type)).toList(),
              ),
              SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        Icons.bar_chart,
                        size: 22,
                        color: Color(0xFF0C8534),
                      ),
                    ),
                    Text('Stats',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Column(
                children: pokemon.stats.entries
                    .map((entry) => _buildStatRow(entry.key, entry.value))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    return TypeChip(type: type, isLarge: true);
  }

  Widget _buildStatRow(String statName, int statValue) {
    Map<String, String> statNameToDisplayName = {
      'hp': 'HP',
      'attack': 'Attack',
      'defense': 'Defense',
      'special-attack': 'Sp. Atk',
      'special-defense': 'Sp. Def',
      'speed': 'Speed',
    };

    double statRatio = statValue / 150.0; // Normalize the stat value

    Color startColor = Colors.red;
    Color endColor = Colors.green;

    Color? barColor =
        ColorTween(begin: startColor, end: endColor).lerp(statRatio);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 110,
                child: Row(
                  children: [
                    SizedBox(
                      width: 70,
                      child: Text(
                        '${statNameToDisplayName[statName]}: ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '$statValue',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: statRatio,
                  backgroundColor: Colors.grey[200],
                  valueColor:
                      AlwaysStoppedAnimation<Color>(barColor ?? Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
