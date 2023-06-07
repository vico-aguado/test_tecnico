import 'package:flutter/material.dart';
import 'package:test_tecnico/src/config/colors.dart';

ThemeData generateTheme() {
  final baseTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    primaryColor: AppColors.primary,
    secondaryHeaderColor: Colors.blue,
    fontFamily: 'Circular',
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
      modalBackgroundColor: Colors.white,
      modalBarrierColor: Colors.black.withOpacity(0.5),
    ),
  );

  const textColor = AppColors.primary;

  return baseTheme.copyWith(
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontSize: 30,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 26,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displayLarge: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 8,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
    ).apply(
      fontFamily: 'Circular',
    ),
  );
}

class AppTheme {
  static final defaultTheme = generateTheme();

  static InputDecoration inputStyle(String hint) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(30),
      ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      prefixIcon: const Padding(
        padding: EdgeInsetsDirectional.only(start: 12),
        child: Icon(Icons.search),
      ),
      hintStyle:
          TextStyle(fontSize: 14, color: AppColors.primary.withOpacity(0.4)),
      hintText: hint,
    );
  }
}
