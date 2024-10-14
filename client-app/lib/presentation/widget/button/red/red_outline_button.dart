import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/widget/button/common/base_outline_button.dart';

class RedOutlineButton extends BaseOutlineButton {
  const RedOutlineButton({
    super.key,
    required super.width,
    required super.height,
    required super.content,
    required super.onPressed,
  });

  @override
  Color get borderColor => ColorSystem.red.shade400;
}
