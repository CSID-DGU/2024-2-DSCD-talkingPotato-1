import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class ConvertButton extends StatelessWidget {
  const ConvertButton({
    super.key,
    required this.size,
    required this.title,
    required this.content,
    required this.assetPath,
    this.onPressed,
  });

  final Size size;
  final String title;
  final String content;
  final String assetPath;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        // Size
        minimumSize: size,
        fixedSize: size,

        // Color
        backgroundColor: ColorSystem.white,
        foregroundColor: ColorSystem.primary,
        disabledBackgroundColor: ColorSystem.neutral.shade300,

        // Border
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgImageView(
              assetPath: assetPath,
              height: 80.0,
            ),
            const Spacer(),
            Text(
              title,
              style: FontSystem.Sub1,
            ),
            Text(
              content,
              style: FontSystem.Sub3.copyWith(
                color: ColorSystem.neutral.shade600,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
