import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class DrugCategoriesCardView extends StatelessWidget {
  const DrugCategoriesCardView({
    super.key,
    required this.title,
    this.content,
  });

  final String title;
  final List<String>? content;

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
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: content!.map(
              (badgeStr) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorSystem.secondary.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badgeStr,
                    style: FontSystem.Sub2.copyWith(
                      height: 1.0,
                      color: ColorSystem.secondary.shade500,
                    ),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
