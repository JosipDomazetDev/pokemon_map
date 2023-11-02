import 'package:bloc_test/bloc_test.dart';
import 'package:pokemon_map/blocs/pokemon_bloc.dart';
import 'package:pokemon_map/model/pokemon.dart';
import 'package:test/test.dart';

import 'mocks/mock_pokemon_repository.dart';

void main() {
  group('PokemonBloc', () {
    late MockPokemonRepository mockPokemonRepository;
    late PokemonBloc pokemonBloc;

    setUp(() {
      mockPokemonRepository = MockPokemonRepository();

      pokemonBloc = PokemonBloc(repository: mockPokemonRepository);
    });

    tearDown(() {
      pokemonBloc.close();
    });

    test('initial state is PokemonInitialState', () {
      expect(pokemonBloc.state, isA<PokemonInitialState>());
    });

    blocTest<PokemonBloc, PokemonState>(
      'emits [PokemonLoadingState, PokemonLoadedState] when FetchPokemonList is added',
      build: () {
        return pokemonBloc;
      },
      act: (bloc) => bloc.add(FetchPokemonList()),
      expect: () => [
        PokemonLoadingState(),
        PokemonLoadedState(mockPokemons),
      ],
    );

    var addPokemon = const Pokemon(
      id: 1,
      name: 'Test',
      height: 1,
      weight: 1,
      types: ['Test'],
      stats: {'Test': 1},
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [PokemonLoadingState, PokemonAddedState, PokemonLoadedState] when AddPokemon is added',
      build: () {
        return pokemonBloc;
      },
      act: (bloc) {
        return bloc.add(AddPokemon(addPokemon));
      },
      expect: () => [
        PokemonLoadingState(),
        PokemonAddedState(addPokemon),
        PokemonLoadedState([...mockPokemons, addPokemon]),
      ],
    );

    blocTest<PokemonBloc, PokemonState>(
      'emits [PokemonLoadingState, PokemonLoadedState] when RefreshPokemonList is added',
      build: () {
        return pokemonBloc;
      },
      act: (bloc) => bloc.add(RefreshPokemonList()),
      expect: () => [
        PokemonLoadingState(),
        PokemonLoadedState(mockPokemons),
      ],
    );
  });
}
