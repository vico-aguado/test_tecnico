import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_tecnico/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(const PokeApp());
}
