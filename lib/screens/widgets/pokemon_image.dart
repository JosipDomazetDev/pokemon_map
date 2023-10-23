import 'package:flutter/material.dart';

import '../../model/pokemon.dart';

class PokemonImage extends StatelessWidget {
  const PokemonImage({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
        image: pokemon.imageUrl,
        placeholder: 'assets/pokeball.png',
        width: 50,
        height: 50,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/pokeball.png',
            width: 50,
            height: 50,
          );
        });
  }
}
