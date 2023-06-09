part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  final PokemonModel model;
  const PokemonState(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends PokemonState {
  const InitialState(super.model);
}

class LoadingState extends PokemonState {
  const LoadingState(super.model);
}

class FailState extends PokemonState {
  final String error;
  const FailState(super.model, this.error);
}

class PokemonsLoadedState extends PokemonState {
  const PokemonsLoadedState(super.model);
}

class PokemonUpdatedState extends PokemonState {
  const PokemonUpdatedState(super.model);
}

class PokemonModel extends Equatable {
  final ScrollController scrollController;
  final int actualOffset;
  final List<Pokemon> pokemonsList;
  final List<Pokemon> favoriteList;

  const PokemonModel({
    required this.scrollController,
    this.actualOffset = 0,
    this.pokemonsList = const [],
    this.favoriteList = const [],
  });

  PokemonModel copyWith({
    ScrollController? scrollController,
    int? actualOffset,
    List<Pokemon>? pokemonsList,
    List<Pokemon>? favoriteList,
  }) {
    return PokemonModel(
      scrollController: scrollController ?? this.scrollController,
      actualOffset: actualOffset ?? this.actualOffset,
      pokemonsList: pokemonsList ?? this.pokemonsList,
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }

  @override
  List<Object> get props => [
        scrollController,
        actualOffset,
        pokemonsList,
        favoriteList,
      ];
}
