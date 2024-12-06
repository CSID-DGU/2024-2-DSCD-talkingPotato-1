import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';

class AddingIconButton extends StatelessWidget {
  const AddingIconButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: ColorSystem.neutral.shade200,
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: icon,
      ),
    );
  }
}
