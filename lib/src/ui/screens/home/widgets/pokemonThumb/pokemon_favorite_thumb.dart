import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/config/colors.dart';
import 'package:test_tecnico/src/config/images.dart';
import 'package:test_tecnico/src/config/texts.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/pokemonThumb/bloc/pokemon_item_bloc.dart';
import 'package:test_tecnico/src/ui/widgets/rotate_pokeball_widget.dart';
import 'package:test_tecnico/src/ui/widgets/text_widget.dart';
import 'package:test_tecnico/src/utils/methods.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonFavThumbWidget extends StatelessWidget {
  const PokemonFavThumbWidget({
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
          return AnimatedContainer(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: pokemon.loaded
                    ? AppColors
                        .colorsList[pokemon.types?.first.type.name]?.first
                    : Colors.grey[100]),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 100,
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: pokemon.loaded
                            ? pokemon.imageUrl.isEmpty
                                ? const Image(
                                    image: AppImages.empty,
                                    opacity: AlwaysStoppedAnimation(0.5),
                                  )
                                : CachedNetworkImage(imageUrl: pokemon.imageUrl)
                            : Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: RotatePokeballWidget(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              )),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: '${Texts.name} ${pokemon.name.capitalize()}',
                          style: TextStyles.titleSmall,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              final bloc = context.read<PokemonItemBloc>();
                              bloc.add(DeleteItemEvent(pokemon));
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey[300])),
                            child: TextWidget(
                              text: Texts.deletePokemon,
                              style: TextStyles.labelLarge,
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
