import 'dart:convert';
import 'dart:math';

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

    List<Pokemon> pokemonList = await _fetchPokemonFromAPI();
    _box.addAll(pokemonList);
    return pokemonList;
  }

  Future<List<Pokemon>> _fetchPokemonFromAPI() async {
    var rng = Random();
    var ids = List<int>.generate(1000, (i) => i + 1)..shuffle(rng);
    ids = ids.sublist(0, 250);

    List<Future<Pokemon>> futures = [];
    for (var id in ids) {
      futures.add(_fetchPokemonDetailsFromAPI(id));
    }

    return await Future.wait(futures);
  }

  Future<Pokemon> _fetchPokemonDetailsFromAPI(int id) async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Pokemon.fromJson(id, data);
    } else {
      throw Exception('Failed to load Pokémon with id $id');
    }
  }


  void addPokemon(Pokemon pokemon) {
    _box.add(pokemon);
  }
}
