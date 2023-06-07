import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_tecnico/src/config/colors.dart';
import 'package:test_tecnico/src/config/images.dart';
import 'package:test_tecnico/src/config/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    scheduleMicrotask(() async {
      await AppImages.precacheAssets(context);
      await Future.delayed(const Duration(milliseconds: 400), () {});
      await AppNavigator.replaceWith(Routes.home);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final randomColor =
        AppColors.colorsList.entries.elementAt(Random().nextInt(17));
    final backgroundColor = randomColor.value.solidColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Opacity(
          opacity: 0.1,
          child: SvgPicture.asset(
            'assets/icons/pokeball_loading.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcATop,
            ),
          ),
        ),
      ),
    );
  }
}
