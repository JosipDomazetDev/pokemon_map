import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/pokemon.dart';

class PokemonRepository {
  Future<List<Pokemon>> fetchPokemonList() async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=151'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];

      final pokemonList = results
          .asMap()
          .map((index, pokemonData) => MapEntry(
              index,
              Pokemon(
                id: index + 1,
                name: pokemonData['name'],
                imageUrl:
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
              )))
          .values
          .toList();

      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }
}
