import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
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
  late ScrollController scrollController;
  late PokemonBloc pokemonBloc;

  const list = [
    Pokemon(
      id: 1,
      name: 'Pikachu 1',
    ),
    Pokemon(
      id: 2,
      name: 'Pikachu 2',
    ),
    Pokemon(
      id: 3,
      name: 'Pikachu 3',
    ),
    Pokemon(
      id: 4,
      name: 'Pikachu 4',
    ),
    Pokemon(
      id: 5,
      name: 'Pikachu 5',
    ),
  ];

  final listFav1 = list.map((e) => e.copyWith(isFavourite: true)).toList();
  final listFav2 = List<Pokemon>.from([list[0].copyWith(isFavourite: true)]);

  setUp(() {
    mockNetworkManager = MockNetworkManager();
    apiDataSource = ApiDataSource(mockNetworkManager);
    pokemonDefaultRepository =
        PokemonDefaultRepository(apiDataSource: apiDataSource);
    scrollController = ScrollController();
    pokemonBloc = PokemonBloc(pokemonDefaultRepository);

    final model = pokemonBloc.state.model.copyWith(
      scrollController: scrollController,
      favoriteList: [],
      pokemonsList: list,
    );
    pokemonBloc.emit(PokemonUpdatedState(model));
  });

  /*

  Verificar si se agrega correctamente un Pokémon al estado global al hacer clic en el botón "Agregar a mi equipo".

  */

  group('Add Pokemon to Favourites', () {
    blocTest<PokemonItemBloc, PokemonItemState>(
      ':: emits [SavedItemState] when SaveItemEvent is called',
      setUp: () {},
      build: () => PokemonItemBloc(
          pokemonBloc, const Pokemon(id: 1, name: 'Pikachu'), 0),
      act: (bloc) {
        bloc.add(const SaveItemEvent());
      },
      expect: () => [
        const SavedItemState(PokemonItemModel(
            data: Pokemon(id: 1, name: 'Pikachu', isFavourite: true), index: 0))
      ],
      verify: (bloc) {},
    );

    blocTest<PokemonBloc, PokemonState>(
      ':: emits [PokemonUpdatedState] when UpdatePokemonItemEvent is called',
      setUp: () {},
      build: () {
        return pokemonBloc;
      },
      act: (bloc) {
        bloc.add(
            UpdatePokemonItemEvent(0, list[0].copyWith(isFavourite: true)));
      },
      expect: () => [
        PokemonUpdatedState(PokemonModel(
          scrollController: scrollController,
          pokemonsList: list,
          favoriteList: List.from([list[0]]),
        ))
      ],
      verify: (bloc) {},
    );
  });

  /*

  Comprobar que no se puedan agregar más del límite permi&do.

  */

  group('Favourites limit (5)', () {
    blocTest<PokemonItemBloc, PokemonItemState>(
      ':: emits [FailedItemState] when SaveItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav1,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () => PokemonItemBloc(pokemonBloc,
          const Pokemon(id: 1, name: 'Pikachu 1', isFavourite: true), 0),
      act: (bloc) {
        bloc.add(const SaveItemEvent());
      },
      expect: () => [
        const FailedItemState(
            PokemonItemModel(
                data: Pokemon(id: 1, name: 'Pikachu', isFavourite: true),
                index: 0),
            '5 is the limit'),
      ],
      verify: (bloc) {},
    );

    blocTest<PokemonBloc, PokemonState>(
      ':: emits [FailState] when UpdatePokemonItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav1,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () {
        return pokemonBloc;
      },
      act: (bloc) {
        bloc.add(UpdatePokemonItemEvent(4, listFav1[4]));
      },
      expect: () => [
        FailState(
            PokemonModel(
                scrollController: scrollController,
                pokemonsList: listFav1,
                favoriteList: listFav1),
            '5 is the limit')
      ],
      verify: (bloc) {},
    );
  });

  /*

  Asegurarse de que no se puedan agregar Pokémon repetidos al equipo.

  */

  group('Same item error', () {
    blocTest<PokemonItemBloc, PokemonItemState>(
      ':: emits [FailedItemState] when SaveItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav2,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () => PokemonItemBloc(pokemonBloc, listFav2[0], 0),
      act: (bloc) {
        bloc.add(const SaveItemEvent());
      },
      expect: () => [
        FailedItemState(
            PokemonItemModel(
              data: listFav2[0],
              index: 0,
            ),
            'Same item'),
      ],
      verify: (bloc) {},
    );

    blocTest<PokemonBloc, PokemonState>(
      ':: emits [FailState] when UpdatePokemonItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav2,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () {
        return pokemonBloc;
      },
      act: (bloc) {
        bloc.add(UpdatePokemonItemEvent(0, listFav2[0]));
      },
      expect: () => [
        FailState(
            PokemonModel(
                scrollController: scrollController,
                pokemonsList: listFav1,
                favoriteList: listFav2),
            'Same item')
      ],
      verify: (bloc) {},
    );
  });

  /*

  Verificar si se puede eliminar correctamente un Pokémon del listado de nuestro equipo pokemon.

  */

  group('Delete item', () {
    blocTest<PokemonItemBloc, PokemonItemState>(
      ':: emits [DeletedItemState] when DeleteItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav2,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () => PokemonItemBloc(pokemonBloc, listFav2[0], 0),
      act: (bloc) {
        bloc.add(DeleteItemEvent(listFav2[0]));
      },
      expect: () => [
        DeletedItemState(
          PokemonItemModel(
            data: listFav2[0].copyWith(isFavourite: false),
            index: 0,
          ),
        ),
      ],
      verify: (bloc) {},
    );

    blocTest<PokemonBloc, PokemonState>(
      ':: emits [PokemonUpdatedState] when UpdatePokemonItemEvent is called',
      setUp: () {
        final model = pokemonBloc.state.model.copyWith(
          scrollController: scrollController,
          favoriteList: listFav2,
          pokemonsList: listFav1,
        );
        pokemonBloc.emit(PokemonUpdatedState(model));
      },
      build: () {
        return pokemonBloc;
      },
      act: (bloc) {
        bloc.add(UpdatePokemonItemEvent(
            0, listFav2[0].copyWith(isFavourite: false)));
      },
      expect: () => [
        PokemonUpdatedState(
          PokemonModel(
              scrollController: scrollController,
              pokemonsList: listFav1,
              favoriteList: const []),
        )
      ],
      verify: (bloc) {},
    );
  });

  /*

  Validar en caso de que no hay ningún pokemon mostrar algún log o prin

  */

  blocTest<PokemonBloc, PokemonState>(
    'List empty error :: emits [PokemonUpdatedState] when UpdatePokemonItemEvent is called',
    setUp: () {
      final model = pokemonBloc.state.model.copyWith(
        scrollController: scrollController,
        favoriteList: [],
        pokemonsList: listFav1,
      );
      pokemonBloc.emit(PokemonUpdatedState(model));
    },
    build: () {
      return pokemonBloc;
    },
    act: (bloc) {
      bloc.add(
          UpdatePokemonItemEvent(0, listFav2[0].copyWith(isFavourite: false)));
    },
    expect: () => [],
    verify: (bloc) {},
  );
}
