import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_tecnico/src/bloc/pokemon_bloc.dart';
import 'package:test_tecnico/src/config/constants.dart';
import 'package:test_tecnico/src/config/routes.dart';
import 'package:test_tecnico/src/config/theme.dart';
import 'package:test_tecnico/src/core/data/repositories/pokemon_repository.dart';
import 'package:test_tecnico/src/core/network.dart';
import 'package:test_tecnico/src/data/source/remote/api_source.dart';

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<NetworkManager>(
          create: (context) => NetworkManager(),
        ),
        RepositoryProvider<ApiDataSource>(
          create: (context) => ApiDataSource(context.read<NetworkManager>()),
        ),
        RepositoryProvider<PokemonRepository>(
          create: (context) => PokemonDefaultRepository(
            apiDataSource: context.read<ApiDataSource>(),
          ),
        ),
      ],
      child: BlocProvider<PokemonBloc>(
        create: (context) => PokemonBloc(context.read<PokemonRepository>())
          ..add(const LoadPokemonsEvent(25, 0)),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Tecnic Test',
          theme: AppTheme.defaultTheme,
          navigatorKey: AppNavigator.navigatorKey,
          onGenerateRoute: AppNavigator.onGenerateRoute,
          builder: (context, child) {
            if (child == null) return const SizedBox.shrink();

            final data = MediaQuery.of(context);
            final smallestSize = min(data.size.width, data.size.height);
            final double textScaleFactor =
                min(smallestSize / AppConstants.designScreenSize.width, 1);

            return MediaQuery(
              data: data.copyWith(
                textScaleFactor: textScaleFactor,
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
