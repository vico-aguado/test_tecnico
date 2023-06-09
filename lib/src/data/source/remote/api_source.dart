import 'package:flutter/foundation.dart';
import 'package:test_tecnico/src/config/constants.dart';
import 'package:test_tecnico/src/core/network.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';

class ApiDataSource {
  ApiDataSource(this.networkManager);

  final NetworkManager networkManager;

  Future<List<Pokemon>> getPokemons(int limit, int offset) async {
    final url = '${AppConstants.urlBase}pokemon?limit=$limit&offset=$offset';
    debugPrint(url);
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      url,
    );

    if (response.statusCode == 200 &&
        response.data != null &&
        response.data!['results'] != null) {
      final results = response.data!['results'] as List;
      if (results.isNotEmpty) {
        return results
            .map(
              (item) => Pokemon.fromMap(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }

  Future<Pokemon> getPokemon(String id) async {
    final url = '${AppConstants.urlBase}pokemon/$id';
    debugPrint(url);
    final response = await networkManager.request<Map<String, dynamic>>(
      RequestMethod.get,
      '${AppConstants.urlBase}pokemon/$id',
    );

    if (response.statusCode == 200 && response.data != null) {
      final data = Pokemon.fromMap(response.data!);
      return data;
    } else {
      throw Exception('Ocurrio un error, vuelva a intentar por favor');
    }
  }
}
