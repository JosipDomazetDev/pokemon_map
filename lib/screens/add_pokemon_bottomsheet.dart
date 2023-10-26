import 'package:flutter/material.dart';

import '../blocs/pokemon_bloc.dart';
import '../model/pokemon.dart';

class AddPokemonBottomSheet extends StatefulWidget {
  final PokemonBloc pokemonBloc;

  const AddPokemonBottomSheet({super.key, required this.pokemonBloc});

  @override
  State<AddPokemonBottomSheet> createState() => _AddPokemonBottomSheetState();
}

enum PokemonCategory { fire, water, grass }

class _AddPokemonBottomSheetState extends State<AddPokemonBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _latitudeController,
                    decoration: const InputDecoration(labelText: 'Latitude'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a latitude';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid latitude';
                      }
                      if (double.parse(value) < -90 ||
                          double.parse(value) > 90) {
                        return 'Please enter a valid latitude range (-90 to 90)';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    controller: _longitudeController,
                    decoration: const InputDecoration(labelText: 'Longitude'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a longitude';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid longitude';
                      }
                      if (double.parse(value) < -180 ||
                          double.parse(value) > 180) {
                        return 'Please enter a valid longitude range (-180 to 180)';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            DropdownButtonFormField(
              items: const [
                DropdownMenuItem(
                  value: PokemonCategory.fire,
                  child: Text('Fire'),
                ),
                DropdownMenuItem(
                  value: PokemonCategory.water,
                  child: Text('Water'),
                ),
                DropdownMenuItem(
                  value: PokemonCategory.grass,
                  child: Text('Grass'),
                ),
              ],
              decoration: const InputDecoration(labelText: 'Category'),
              validator: (value) {
                if (value == null) {
                  return 'Please select a category';
                }
                return null;
              },
              onChanged: (Object? value) {},
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final pokemon = Pokemon.createNew(
                    id: DateTime.now().microsecondsSinceEpoch,
                    name: _nameController.text,
                    latitude: double.parse(_latitudeController.text),
                    longitude: double.parse(_longitudeController.text),
                  );

                  widget.pokemonBloc.add(AddPokemon(pokemon));

                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
