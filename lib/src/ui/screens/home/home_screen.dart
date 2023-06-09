import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/config/images.dart';
import 'package:test_tecnico/src/config/texts.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/favourites_list_widget.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/no_data_widget.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/pokemonThumb/pokemon_thumb.dart';
import 'package:test_tecnico/src/ui/widgets/rotate_pokeball_widget.dart';
import 'package:test_tecnico/src/ui/widgets/text_widget.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void showFavourites(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: size.height * .8,
          child: const FavouritesListWidget(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: Texts.title,
          style: TextStyles.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, state) {
                return badges.Badge(
                  showBadge: state.model.favoriteList.isNotEmpty,
                  onTap: () {
                    showFavourites(context);
                  },
                  position: badges.BadgePosition.bottomStart(start: -5),
                  badgeContent:
                      Text(state.model.favoriteList.length.toString()),
                  child: GestureDetector(
                    onTap: () {
                      showFavourites(context);
                    },
                    child: const Image(
                      image: AppImages.pokeball,
                      height: 40,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Image(
                    image: AppImages.pokedesk,
                    height: 35,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: TextWidget(
                      text: Texts.instructions,
                      style: TextStyles.labelMedium,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: BlocBuilder<PokemonBloc, PokemonState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    if (state.model.pokemonsList.isEmpty) {
                      return Center(
                          child: RotatePokeballWidget(
                        color: Colors.grey.withOpacity(0.30),
                      ));
                    }
                  }

                  if (state.model.pokemonsList.isEmpty) {
                    return const NoDataWidget();
                  }

                  return ListView.builder(
                    controller: state.model.scrollController,
                    itemCount: state.model.pokemonsList.length,
                    itemBuilder: (context, index) {
                      return PokemonThumbWidget(
                        index: index,
                        pokemon: state.model.pokemonsList[index],
                      );
                    },
                  );
                },
              )),
              BlocBuilder<PokemonBloc, PokemonState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    if (state.model.pokemonsList.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: RotatePokeballWidget(
                          size: 40,
                          color: Colors.grey.withOpacity(0.50),
                        )),
                      );
                    }
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
