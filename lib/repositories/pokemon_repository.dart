import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../model/pokemon.dart';

class PokemonRepository {
  final _box = Hive.box<Pokemon>('pokemonBox');

  Future<List<Pokemon>> reloadPokemonBox() async {
    await _box.clear();
    return await fetchPokemonList();
  }

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
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=1000'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> results = data['results'];

      final pokemonList = results
          .asMap()
          .map((index, pokemonData) =>
              MapEntry(index, Pokemon.fromJson(index, pokemonData)))
          .values
          .toList();
      pokemonList.shuffle();

      return pokemonList.sublist(0, 250);
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  void addPokemon(Pokemon pokemon) {
    _box.add(pokemon);
    fetchPokemonList();
  }
}
