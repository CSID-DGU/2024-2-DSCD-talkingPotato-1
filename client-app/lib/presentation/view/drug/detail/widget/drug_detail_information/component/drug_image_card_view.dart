import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class DrugImageCardView extends StatelessWidget {
  const DrugImageCardView({
    super.key,
    required this.mainTitle,
    required this.subTitle,
    required this.svgPath,
    this.content,
  });

  final String mainTitle;
  final String subTitle;
  final String svgPath;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: FontSystem.Sub1.copyWith(
                    color: ColorSystem.neutral.shade500,
                  ),
                ),
                Text(
                  subTitle,
                  style: FontSystem.H4.copyWith(
                    color: ColorSystem.neutral.shade900,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgImageView(
              assetPath: svgPath,
              width: Get.width / 2 - 40 - 32,
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          width: Get.width - 40,
          decoration: BoxDecoration(
            color: ColorSystem.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            content ?? '해당하는 정보가 없습니다.',
            style: FontSystem.Sub2.copyWith(
              height: 1.6,
              color: ColorSystem.neutral.shade500,
            ),
          ),
        )
      ],
    );
  }
}
