import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_map/model/pokemon.dart';
import 'package:pokemon_map/screens/widgets/pokemon_image.dart';

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
        title: Text('Pokémons'),
      ),
      body: buildBloc(context),
    );
  }

  Widget buildBloc(BuildContext context) {
    return BlocConsumer<PokemonBloc, PokemonState>(
      listener: (context, state) {
        if (state is PokemonErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<PokemonBloc>(context).add(RefreshPokemonList());
              return Future(() {});
            },
            child: buildList(state));
      },
    );
  }

  Widget buildList(PokemonState state) {
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
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SvgPicture.network(
                        pokemon.detailImgUrl,
                        semanticsLabel: pokemon.displayName,
                        width: 90,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Text(pokemon.displayName,
                        style: const TextStyle(fontSize: 18))
                  ],
                ),
              ),
            );
          }

          return ListTile(
            leading: PokemonImage(pokemon: pokemon),
            title: Text(pokemon.displayName),
          );
        },
      );
    } else if (state is PokemonErrorState) {
      return Center(child: Text('Error: ${state.error}'));
    } else {
      return Container();
    }
  }
}
