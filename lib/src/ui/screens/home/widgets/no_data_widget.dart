import 'package:flutter/material.dart';
import 'package:test_tecnico/src/config/images.dart';
import 'package:test_tecnico/src/config/texts.dart';
import 'package:test_tecnico/src/ui/widgets/text_widget.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Image(
            image: AppImages.empty,
            opacity: AlwaysStoppedAnimation(0.7),
          ),
          TextWidget(
            text: Texts.noData,
            style: TextStyles.labelLarge,
          ),
        ],
      ),
    );
  }
}
