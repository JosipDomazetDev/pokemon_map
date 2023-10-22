import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/pokemon_bloc.dart';
import '../repositories/pokemon_repository.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PokemonBloc>().add(FetchPokemonList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: buildList(context),
    );
  }

  Widget buildList(BuildContext context) {
    return BlocConsumer<PokemonBloc, PokemonState>(
      listener: (context, state) {
        if (state is PokemonErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoadedState) {
          final pokemonList = state.pokemonList;
          return ListView.builder(
            itemCount: pokemonList.length,
            itemBuilder: (context, index) {
              final pokemon = pokemonList[index];

              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      children: [
                        Image.network(pokemon.imageUrl,
                            cacheHeight: 120, cacheWidth: 150),
                        Text(pokemon.displayName)
                      ],
                    ),
                  ),
                );
              }

              return ListTile(
                leading: Image.network(pokemon.imageUrl),
                title: Text(pokemon.displayName),
              );
            },
          );
        } else if (state is PokemonErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }
}
