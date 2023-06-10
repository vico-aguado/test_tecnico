import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:test_tecnico/src/core/data/repositories/pokemon_repository.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc(this.repository)
      : super(InitialState(PokemonModel(
          scrollController: ScrollController(),
        ))) {
    on<LoadPokemonsEvent>(_loadPokemons);
    on<InitEvent>(_init);
    on<UpdatePokemonItemEvent>(_updatePokemon);
  }

  final PokemonRepository repository;

  @override
  Future<void> close() async {
    state.model.scrollController.removeListener(_scrollListener);
    await super.close();
  }

  void _scrollListener() {
    if (state.model.scrollController.position.atEdge) {
      final isTop = state.model.scrollController.position.pixels == 0;

      if (!isTop) {
        add(LoadPokemonsEvent(25, state.model.actualOffset));
      }
    }
  }

  Future<void> _init(
    InitEvent event,
    Emitter<PokemonState> emit,
  ) async {
    state.model.scrollController.addListener(_scrollListener);
    add(const LoadPokemonsEvent(25, 0));
  }

  Future<void> _loadPokemons(
    LoadPokemonsEvent event,
    Emitter<PokemonState> emit,
  ) async {
    emit(
      LoadingState(state.model),
    );

    try {
      final result = await repository.getPokemons(
        limit: event.limit,
        offset: event.offset,
      );

      var list = <Pokemon>[];

      if (event.offset != 0) {
        list = List<Pokemon>.from(state.model.pokemonsList);
      }

      list.addAll(result);

      final model = state.model.copyWith(
        actualOffset: event.offset + 25,
        pokemonsList: list,
      );

      emit(PokemonsLoadedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }

  Future<void> _updatePokemon(
    UpdatePokemonItemEvent event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      final list = List<Pokemon>.from(state.model.pokemonsList);

      list[event.index] = event.data;

      final favList = List<Pokemon>.from(state.model.favoriteList);

      var model = state.model.copyWith(
        pokemonsList: list,
        favoriteList: favList,
      );

      if (event.data.isFavourite) {
        if (favList.length < 5) {
          List<Pokemon> item =
              favList.where((element) => element.id == event.data.id).toList();
          if (item.isEmpty) {
            favList.add(event.data);
          } else {
            emit(FailState(model, 'Same item'));
            return;
          }
        } else {
          emit(FailState(model, '5 is the limit'));
          return;
        }
      } else {
        favList.remove(event.data);
      }

      model = model.copyWith(
        favoriteList: favList,
      );

      emit(PokemonUpdatedState(model));
    } catch (e) {
      emit(FailState(state.model, e.toString()));
    }
  }
}
