import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/pokemon.dart';
import '../repositories/pokemon_repository.dart';

abstract class PokemonEvent {}

class FetchPokemonList extends PokemonEvent {}

class AddPokemon extends PokemonEvent {
  final Pokemon pokemon;

  AddPokemon(this.pokemon);
}

// States
abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<Pokemon> pokemonList;

  PokemonLoadedState(this.pokemonList);
}

class PokemonErrorState extends PokemonState {
  final String error;

  PokemonErrorState(this.error);
}

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository repository;

  PokemonBloc({required this.repository}) : super(PokemonInitialState()) {
    on<FetchPokemonList>((event, emit) async {
      print("erere");
      try {
        emit(PokemonLoadingState());
        final pokemons = await repository.fetchPokemonList();
        print("Emitting PokemonLoadedState");
        emit(PokemonLoadedState(pokemons));
      } catch (error) {
        emit(PokemonErrorState(error.toString()));
      }
    });

    on<AddPokemon>((event, emit) async {
      try {
        emit(PokemonLoadingState());
        await repository.addPokemon(event.pokemon);
        final pokemons = await repository.fetchPokemonList();
        emit(PokemonLoadedState(pokemons));
      } catch (error) {
        emit(PokemonErrorState(error.toString()));
      }
    });
  }
}
