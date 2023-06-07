// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

const String _imagePath = 'assets/images';

class _Image extends AssetImage {
  const _Image(String fileName) : super('$_imagePath/$fileName');
}

class AppImages {
  static const empty = _Image('empty.png');

  static Future<void> precacheAssets(BuildContext context) async {
    await precacheImage(empty, context);
  }
}
