import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class DrugBriefDefaultItemView extends StatelessWidget {
  const DrugBriefDefaultItemView({
    super.key,
    required this.state,
    required this.onTapContext,
    required this.onTapPlus,
  });

  final DrugBriefState state;
  final Function() onTapContext;
  final Function() onTapPlus;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          top: 4,
          bottom: 4,
        ),
        child: InkWell(
          onTap: onTapContext,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 12,
              bottom: 12,
            ),
            child: Row(
              children: [
                _buildBadge(),
                const SizedBox(width: 8),
                _buildContentView(),
                const Spacer(),
                _buildPlusView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorSystem.secondary.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        state.type == 'MEDICINE' ? "의약품" : "영양제",
        style: FontSystem.Sub3.copyWith(
          color: state.type == 'MEDICINE'
              ? ColorSystem.secondary.shade500
              : ColorSystem.primary.shade500,
          fontWeight: FontWeight.w700,
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return SizedBox(
      width: Get.width - 168,
      child: Text(
        state.name,
        style: FontSystem.H5.copyWith(
          height: 1.0,
          color: ColorSystem.neutral.shade500,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildPlusView() {
    return GestureDetector(
      onTap: onTapPlus,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: ColorSystem.secondary.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: SvgImageView(
            assetPath: "assets/icons/radius_plus.svg",
            width: 18,
            height: 18,
            color: ColorSystem.primary,
          ),
        ),
      ),
    );
  }
}
