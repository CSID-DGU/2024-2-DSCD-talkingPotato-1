import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class DrugFloatingActionButton extends StatelessWidget {
  const DrugFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        // Color
        backgroundColor: ColorSystem.primary,
        foregroundColor: ColorSystem.white,

        disabledBackgroundColor: ColorSystem.neutral.shade300,

        // Padding
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),

        // Border
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SvgImageView(
            assetPath: 'assets/icons/pill.svg',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 8),
          Text(
            '복약 추가하기',
            style: FontSystem.Sub1.copyWith(
              color: ColorSystem.white,
            ),
          ),
        ],
      ),
    );
  }
}
