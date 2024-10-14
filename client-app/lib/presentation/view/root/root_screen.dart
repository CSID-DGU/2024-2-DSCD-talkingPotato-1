import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/view_model/root/root_view_model.dart';

class RootScreen extends GetView<RootViewModel> {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorSystem.white,
      body: Center(
        child: Text(
          'Root Screen',
          style: FontSystem.H6,
        ),
      ),
    );
  }
}
