import 'package:flutter/foundation.dart';
import 'package:test_tecnico/src/data/source/remote/api_source.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getPokemons({required int limit, required int offset});
  Future<Pokemon?> getPokemon(String number);
  //TODO: add favorites
}

class PokemonDefaultRepository extends PokemonRepository {
  PokemonDefaultRepository({
    required this.apiDataSource,
  });

  final ApiDataSource apiDataSource;

  @override
  Future<List<Pokemon>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    final pokemonApiModels = await apiDataSource.getPokemons(limit, offset);
    return pokemonApiModels;
  }

  @override
  Future<Pokemon?> getPokemon(String number) async {
    try {
      final pokemonApiModel = await apiDataSource.getPokemon(number);
      return pokemonApiModel;
    } catch (e) {
      debugPrint(e.toString());
    }

    return null;
  }
}
