import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/config/colors.dart';
import 'package:test_tecnico/src/config/routes.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/no_data_widget.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/pokemonThumb/pokemon_favorite_thumb.dart';

class FavouritesListWidget extends StatelessWidget {
  const FavouritesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  AppNavigator.pop();
                },
                child: Container(
                  color: Colors.transparent,
                  child: const Icon(
                    Icons.close,
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          BlocConsumer<PokemonBloc, PokemonState>(
            listener: (context, state) {
              if (state is PokemonUpdatedState &&
                  state.model.favoriteList.isEmpty) {
                AppNavigator.pop();
              }
            },
            builder: (context, state) {
              return Expanded(
                  child: state.model.favoriteList.isEmpty
                      ? const NoDataWidget()
                      : ListView.builder(
                          itemCount: state.model.favoriteList.length,
                          itemBuilder: (context, index) {
                            final pokemon = state.model.favoriteList[index];
                            return PokemonFavThumbWidget(
                                pokemon: pokemon, index: index);
                          },
                        ));
            },
          ),
        ],
      ),
    );
  }
}
