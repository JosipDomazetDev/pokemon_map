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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: RepositoryProvider(
        create: (context) => PokemonRepository(),
        child: BlocProvider(
          create: (context) =>
              PokemonBloc(repository: context.read<PokemonRepository>())
                ..add(FetchPokemonList()),
          child: BlocBuilder<PokemonBloc, PokemonState>(
            builder: (context, state) {
              if (state is PokemonLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PokemonLoadedState) {
                final pokemonList = state.pokemonList;
                return ListView.builder(
                  itemCount: pokemonList.length,
                  itemBuilder: (context, index) {
                    final pokemon = pokemonList[index];
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
          ),
        ),
      ),
    );
  }
}
