import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/widget/button/common/base_fill_button.dart';

class YellowFillButton extends BaseFillButton {
  const YellowFillButton({
    super.key,
    required super.width,
    required super.height,
    required super.content,
    required super.onPressed,
  });

  @override
  Color get backgroundColor => ColorSystem.yellow.shade400;
}
