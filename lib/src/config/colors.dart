import 'package:flutter/material.dart';

class AppColors {
  static const DualColors normal =
      DualColors(Color(0xFF9199a3), Color(0xFFa3a39e));
  static const DualColors fighting =
      DualColors(Color(0xFFcf4266), Color(0xFFe84247));
  static const DualColors flying =
      DualColors(Color(0xFF8fa6d9), Color(0xFFa6c2f2));
  static const DualColors poison =
      DualColors(Color(0xFFa863c7), Color(0xFFc263d4));
  static const DualColors ground =
      DualColors(Color(0xFFdb7545), Color(0xFFd19463));
  static const DualColors rock =
      DualColors(Color(0xFFc4b58a), Color(0xFFd6cc8f));
  static const DualColors bug =
      DualColors(Color(0xFFb0c736), Color(0xFF91bd2b));
  static const DualColors ghost =
      DualColors(Color(0xFF526bab), Color(0xFF7873d4));
  static const DualColors steel =
      DualColors(Color(0xFF52879e), Color(0xFF59a6ab));
  static const DualColors fire =
      DualColors(Color(0xFFfa9c52), Color(0xFFfaad45));
  static const DualColors water =
      DualColors(Color(0xFF549ede), Color(0xFF69bae3));
  static const DualColors grass =
      DualColors(Color(0xFF5ebd52), Color(0xFF59c278));
  static const DualColors electric =
      DualColors(Color(0xFFedd63d), Color(0xFFfae373));
  static const DualColors psychic =
      DualColors(Color(0xFFf57070), Color(0xFFff9e91));
  static const DualColors ice =
      DualColors(Color(0xFF70ccbd), Color(0xFF8cded4));
  static const DualColors dragon =
      DualColors(Color(0xFF91bd2b), Color(0xFFb0c736));
  static const DualColors dark =
      DualColors(Color(0xFF595761), Color(0xFF6e7587));
  static const DualColors fairy =
      DualColors(Color(0xFFed8ce6), Color(0xFFf2a6e8));

  static const Map<String, DualColors> colorsList = {
    'normal': normal,
    'fighting': fighting,
    'flying': flying,
    'poison': poison,
    'ground': ground,
    'rock': rock,
    'bug': bug,
    'ghost': ghost,
    'steel': steel,
    'fire': fire,
    'water': water,
    'grass': grass,
    'electric': electric,
    'psychic': psychic,
    'ice': ice,
    'dragon': dragon,
    'dark': dark,
    'fairy': fairy,
  };

  static const background = Color(0xFFFFFFFF);
  static const primary = Color(0xFF303943);
  static const badge = Colors.red;
}

class DualColors {
  const DualColors(
    this.first,
    this.second,
  );
  final Color first;
  final Color second;

  Color get solidColor {
    return first;
  }
}
