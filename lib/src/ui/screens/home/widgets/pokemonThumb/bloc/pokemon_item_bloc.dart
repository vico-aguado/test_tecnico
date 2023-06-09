import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';

part 'pokemon_item_event.dart';
part 'pokemon_item_state.dart';

class PokemonItemBloc extends Bloc<PokemonItemEvent, PokemonItemState> {
  PokemonItemBloc(
    this.pokemonBloc,
    this.data,
    this.index,
  ) : super(
          InitialItemState(
            PokemonItemModel(
              data: data,
              index: index,
            ),
          ),
        ) {
    on<LoadItemDataEvent>(_loadData);
    on<SaveItemEvent>(_saveItem);
  }

  final PokemonBloc pokemonBloc;
  final Pokemon data;
  final int index;

  Future<void> _saveItem(
    SaveItemEvent event,
    Emitter<PokemonItemState> emit,
  ) async {}

  Future<void> _loadData(
    LoadItemDataEvent event,
    Emitter<PokemonItemState> emit,
  ) async {
    if (!state.model.data.loaded) {
      emit(
        LoadingItemState(state.model),
      );

      try {
        var pokemonResult = await pokemonBloc.repository.getPokemon(
          data.id.toString(),
        );

        if (pokemonResult != null) {
          pokemonResult = pokemonResult.copyWith(loaded: true);

          final model = state.model.copyWith(data: pokemonResult);
          pokemonBloc.add(UpdatePokemonItemEvent(index, pokemonResult));
          emit(LoadedItemState(model));
        } else {
          emit(FailedItemState(state.model, 'No data'));
        }
      } catch (e) {
        emit(FailedItemState(state.model, e.toString()));
      }
    }
  }
}
