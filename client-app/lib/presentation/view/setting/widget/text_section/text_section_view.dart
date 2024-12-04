import 'package:flutter/material.dart';
import 'package:wooahan/app/config/font_system.dart';

class TextSectionView extends StatelessWidget {
  const TextSectionView({
    super.key,
    required this.title,
    required this.textColor,
    required this.onTap,
  });

  final String title;
  final Color textColor;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Text(
              title,
              style: FontSystem.H5.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
