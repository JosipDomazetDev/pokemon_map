import 'package:pokemon_map/model/pokemon.dart';
import 'package:pokemon_map/repositories/pokemon_repository.dart';

var mockPokemons = <Pokemon>[
  const Pokemon(
    id: 1,
    name: 'Pikachu',
    height: 1,
    weight: 1,
    types: ['Electric'],
    stats: {'Test': 1},
  ),
  const Pokemon(
    id: 100,
    name: 'Relaxo',
    height: 1,
    weight: 1,
    types: ['Normal'],
    stats: {'Test': 1},
  )
];

class MockPokemonRepository implements PokemonRepository {
  List<Pokemon> pokemons = <Pokemon>[...mockPokemons];

  @override
  void addPokemon(Pokemon pokemon) {
    pokemons.add(pokemon);
  }

  @override
  Future<List<Pokemon>> fetchPokemonList() {
    return Future.value(pokemons);
  }

  @override
  Future<List<Pokemon>> reloadPokemonBox() {
    return Future.value(pokemons);
  }
}
