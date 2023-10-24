import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:pokemon_map/model/pokemon.dart';
import 'package:pokemon_map/screens/widgets/pokemon_image.dart';

import '../blocs/pokemon_bloc.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoadedState) {
          final pokemonList = state.pokemonList;
          return buildPokemonMap(pokemonList);
        } else if (state is PokemonErrorState) {
          return Center(child: Text('Error: ${state.error}'));
        } else {
          return Container();
        }
      },
    );
  }

  Scaffold buildPokemonMap(List<Pokemon> pokemons) {
    final markers =
        pokemons.where((pokemon) => pokemon.imageUrl.isNotEmpty).map((pokemon) {
      return Marker(
          point: LatLng(pokemon.latitude, pokemon.longitude),
          width: 60,
          height: 60,
          child: PokemonImage(pokemon: pokemon));
    }).toList();

    return Scaffold(
        body: FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.5, 100.09),
        initialZoom: 3,
        interactionOptions: InteractionOptions(
            flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(markers: markers),
        CurrentLocationLayer(
          style: const LocationMarkerStyle(
            marker: DefaultLocationMarker(
              child: Icon(
                Icons.navigation,
                color: Colors.white,
              ),
            ),
            markerSize: Size(40, 40),
            markerDirection: MarkerDirection.heading,
          ),
        )
      ],
    ));
  }
}
