import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokemon_map/screens/widgets/pokemon_image.dart';

import '../blocs/pokemon_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        title: const Text('Pokémons'),
      ),
      body: buildBloc(context),
    );
  }

  Widget buildBloc(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
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

  final Map<String, Color?> typeColors = {
    'normal': Colors.brown[400],
    'fire': Colors.red[600],
    'water': Colors.blue[600],
    'electric': Colors.yellow[600],
    'grass': Colors.green[600],
    'ice': Colors.cyanAccent[400],
    'fighting': Colors.orange[900],
    'poison': Colors.purple[600],
    'ground': Colors.orange[300],
    'flying': Colors.indigo[200],
    'psychic': Colors.pink[300],
    'bug': Colors.lightGreen[500],
    'rock': Colors.grey,
    'ghost': Colors.indigo[700],
    'dragon': Colors.indigo[800],
    'dark': Colors.brown[900],
    'steel': Colors.blueGrey,
    'fairy': Colors.pinkAccent[100]
  };

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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: FadeInImage.assetNetwork(
                            image: pokemon.detailImgUrl,
                            placeholder: 'assets/pokeball.png',
                            width: 100,
                            height: 100,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/pokeball.png',
                                width: 50,
                                height: 50,
                              );
                            })),
                    const SizedBox(width: 24),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(pokemon.displayName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          Column(
                            children: [
                              Text("Height: ${pokemon.height} m",
                                  style: const TextStyle(
                                      fontSize: 11)),
                              const SizedBox(width: 8),
                              Text("Weight: ${pokemon.weight} kg",
                                  style: const TextStyle(
                                      fontSize: 11)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...pokemon.types
                                    .map((type) => Container(
                                  margin:
                                  const EdgeInsets.symmetric(horizontal: 2),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: typeColors[type] ?? Colors.grey,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    type,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ))
                                    .toList(),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
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
