import 'package:flutter/material.dart';
import 'package:test_tecnico/src/config/images.dart';
import 'package:test_tecnico/src/ui/widgets/text_widget.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: 'Intercambio Pokémon',
          style: TextStyles.titleLarge,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: badges.Badge(
              onTap: () {},
              position: badges.BadgePosition.bottomStart(start: -5),
              badgeContent: const Text('5'),
              child: const Image(
                image: AppImages.pokeball,
                height: 40,
              ),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AppImages.pokedesk,
                  height: 35,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextWidget(
                    text:
                        'Selecciona hasta 5 Pokémons para agregarlos a tu equipo',
                    style: TextStyles.labelMedium,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
