part of 'pokemon_item_bloc.dart';

abstract class PokemonItemState extends Equatable {
  const PokemonItemState(this.model);
  final PokemonItemModel model;

  @override
  List<Object> get props => [];
}

class InitialItemState extends PokemonItemState {
  const InitialItemState(super.model);
}

class LoadingItemState extends PokemonItemState {
  const LoadingItemState(super.model);
}

class LoadedItemState extends PokemonItemState {
  const LoadedItemState(super.model);
}

class FailedItemState extends PokemonItemState {
  const FailedItemState(super.model, this.error);
  final String error;
}

class SavedItemState extends PokemonItemState {
  const SavedItemState(super.model);
}

class DeletedItemState extends PokemonItemState {
  const DeletedItemState(super.model);
}

class PokemonItemModel extends Equatable {
  const PokemonItemModel({
    required this.data,
    required this.index,
  });
  final Pokemon data;
  final int index;

  PokemonItemModel copyWith({
    Pokemon? data,
    int? index,
  }) {
    return PokemonItemModel(
      data: data ?? this.data,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        data,
        index,
      ];
}
