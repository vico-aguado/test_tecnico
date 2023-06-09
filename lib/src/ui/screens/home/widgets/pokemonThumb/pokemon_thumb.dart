import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/pokemonThumb/bloc/pokemon_item_bloc.dart';
import 'package:test_tecnico/src/ui/widgets/text_widget.dart';

class PokemonThumbWidget extends StatelessWidget {
  const PokemonThumbWidget({
    super.key,
    required this.pokemon,
    required this.index,
  });
  final Pokemon pokemon;
  final int index;

  @override
  Widget build(BuildContext context) {
    final pokemonBloc = context.read<PokemonBloc>();

    return BlocProvider<PokemonItemBloc>(
      create: (context) => PokemonItemBloc(
        pokemonBloc,
        pokemon,
        index,
      )..add(const LoadItemDataEvent()),
      child: BlocBuilder<PokemonItemBloc, PokemonItemState>(
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 60,
            color: Colors.amber,
            child: TextWidget(
              text: pokemon.name,
            ),
          );
        },
      ),
    );
  }
}
