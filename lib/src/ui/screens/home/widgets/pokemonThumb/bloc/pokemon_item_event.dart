part of 'pokemon_item_bloc.dart';

abstract class PokemonItemEvent extends Equatable {
  const PokemonItemEvent();

  @override
  List<Object> get props => [];
}

class LoadItemDataEvent extends PokemonItemEvent {
  const LoadItemDataEvent();
}

class SaveItemEvent extends PokemonItemEvent {
  const SaveItemEvent();
}
