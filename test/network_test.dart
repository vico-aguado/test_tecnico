import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/config/constants.dart';
import 'package:test_tecnico/src/core/data/repositories/pokemon_repository.dart';
import 'package:test_tecnico/src/core/network.dart';
import 'package:test_tecnico/src/data/source/remote/api_source.dart';
import 'package:test_tecnico/src/domain/entities/pokemon_model.dart';
import 'package:test_tecnico/src/ui/screens/home/widgets/pokemonThumb/bloc/pokemon_item_bloc.dart';

class MockNetworkManager extends Mock implements NetworkManager {
  @override
  Dio get dio => Dio();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockNetworkManager mockNetworkManager;
  late ApiDataSource apiDataSource;
  late PokemonDefaultRepository pokemonDefaultRepository;

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    apiDataSource = ApiDataSource(mockNetworkManager);
    pokemonDefaultRepository =
        PokemonDefaultRepository(apiDataSource: apiDataSource);
  });

  /*

    Verificar si se realiza una solicitud al endpoint correcto para obtener la lista de Pokémons.

  */

  blocTest<PokemonBloc, PokemonState>(
    'Get Pokemons List :: emits [LoadingState, PokemonsLoadedState] when LoadPokemonsEvent is called',
    setUp: () {
      when(() => mockNetworkManager.request<Map<String, dynamic>>(
                RequestMethod.get,
                '${AppConstants.urlBase}pokemon?limit=20&offset=0',
              ))
          .thenAnswer((_) async => Response(
              data: {'results': []},
              statusCode: 200,
              requestOptions: RequestOptions()));
    },
    build: () => PokemonBloc(
      pokemonDefaultRepository,
    ),
    act: (bloc) {
      bloc.add(const LoadPokemonsEvent(20, 0));
    },
    expect: () => [
      isA<LoadingState>(),
      isA<PokemonsLoadedState>(),
    ],
    verify: (bloc) {
      verify(
        () => mockNetworkManager.request<Map<String, dynamic>>(
          RequestMethod.get,
          '${AppConstants.urlBase}pokemon?limit=20&offset=0',
        ),
      ).called(1);
    },
  );

  /*

  Asegurarse de que se realicen solicitudes adicionales a los endpoints de detalles para obtener información adicional de los Pokémons.

  */

  blocTest<PokemonItemBloc, PokemonItemState>(
    'Get Pokemon detail :: emits [LoadingItemState, LoadedItemState] when LoadItemDataEvent is called',
    setUp: () {
      when(() => mockNetworkManager.request<Map<String, dynamic>>(
                RequestMethod.get,
                '${AppConstants.urlBase}pokemon/1',
              ))
          .thenAnswer((_) async => Response(
              data: {'id': 1, 'name': 'Pikachu'},
              statusCode: 200,
              requestOptions: RequestOptions()));
    },
    build: () => PokemonItemBloc(
        PokemonBloc(
          pokemonDefaultRepository,
        ),
        const Pokemon(id: 1, name: 'Pikachu'),
        0),
    act: (bloc) {
      bloc.add(const LoadItemDataEvent());
    },
    expect: () => [
      isA<LoadingItemState>(),
      isA<LoadedItemState>(),
    ],
    verify: (bloc) {
      verify(
        () => mockNetworkManager.request<Map<String, dynamic>>(
          RequestMethod.get,
          '${AppConstants.urlBase}pokemon/1',
        ),
      ).called(1);
    },
  );
}
