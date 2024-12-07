import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class DrugDefaultCardView extends StatelessWidget {
  const DrugDefaultCardView({
    super.key,
    required this.title,
    this.content,
  });

  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: Get.width - 40,
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: FontSystem.H4.copyWith(
              color: ColorSystem.neutral.shade900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            content ?? '해당하는 정보가 없습니다.',
            style: FontSystem.Sub2.copyWith(
              height: 1.6,
              color: ColorSystem.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
