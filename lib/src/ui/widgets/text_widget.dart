import 'package:flutter/material.dart';

enum TextStyles {
  titleLarge,
  titleMedium,
  titleSmall,
  displayLarge,
  displayMedium,
  labelLarge,
  labelMedium,
  labelSmall,
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    this.textAlign = TextAlign.left,
    required this.text,
    this.style,
    this.color,
  });
  final String text;
  final TextAlign textAlign;
  final TextStyles? style;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final styleTMP = _getStyle(style, context);

    return Text(
      text,
      textAlign: textAlign,
      style: color != null ? styleTMP?.copyWith(color: color) : styleTMP,
    );
  }

  TextStyle? _getStyle(TextStyles? value, BuildContext context) {
    switch (value) {
      case TextStyles.titleLarge:
        return Theme.of(context).textTheme.titleLarge;
      case TextStyles.titleMedium:
        return Theme.of(context).textTheme.titleMedium;
      case TextStyles.titleSmall:
        return Theme.of(context).textTheme.titleSmall;
      case TextStyles.displayLarge:
        return Theme.of(context).textTheme.displayLarge;
      case TextStyles.displayMedium:
        return Theme.of(context).textTheme.displayMedium;
      case TextStyles.labelLarge:
        return Theme.of(context).textTheme.labelLarge;
      case TextStyles.labelMedium:
        return Theme.of(context).textTheme.labelMedium;
      case TextStyles.labelSmall:
        return Theme.of(context).textTheme.labelSmall;
      default:
        return Theme.of(context).textTheme.labelMedium;
    }
  }
}
