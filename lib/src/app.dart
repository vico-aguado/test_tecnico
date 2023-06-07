import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_tecnico/src/config/constants.dart';
import 'package:test_tecnico/src/config/routes.dart';

class PokeApp extends StatelessWidget {
  const PokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tecnic Test',
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
    );
  }
}
