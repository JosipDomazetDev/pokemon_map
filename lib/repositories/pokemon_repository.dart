import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

import '../model/pokemon.dart';

class PokemonRepository {
  final _box = Hive.box<Pokemon>('pokemonBox');

  Future<List<Pokemon>> fetchPokemonList() async {
    if (_box.isNotEmpty) {
      return _box.values.toList();
    }

    final pokemonList = await _fetchPokemonFromAPI();
    _box.addAll(pokemonList);
    return pokemonList;
  }

  Future<List<Pokemon>> _fetchPokemonFromAPI() async {
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
              )))
          .values
          .toList();

      return pokemonList;
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  void addPokemon(Pokemon pokemon) {
    print('Adding Pokémon ${pokemon.name} to the database...');
    _box.add(pokemon);
    fetchPokemonList();
  }
}
