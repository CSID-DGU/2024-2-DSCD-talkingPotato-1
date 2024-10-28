import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class UserNameLayer extends StatelessWidget {
  const UserNameLayer({
    super.key,
    required this.nickname,
  });

  final String nickname;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 240,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorSystem.primary,
            ColorSystem.primary.shade400,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: ColorSystem.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "$nickname님",
            style: FontSystem.H1.copyWith(
              color: ColorSystem.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "오늘 하루는 어떠셨나요?",
            style: FontSystem.H5.copyWith(
              color: ColorSystem.white,
            ),
          ),
        ],
      ),
    );
  }
}
