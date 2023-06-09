part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {
  const PokemonEvent();

  @override
  List<Object> get props => [];
}

class InitEvent extends PokemonEvent {
  const InitEvent();
}

class LoadPokemonsEvent extends PokemonEvent {
  const LoadPokemonsEvent(
    this.limit,
    this.offset,
  );
  final int limit;
  final int offset;
}

class UpdatePokemonItemEvent extends PokemonEvent {
  const UpdatePokemonItemEvent(
    this.index,
    this.data,
  );
  final int index;
  final Pokemon data;
}
