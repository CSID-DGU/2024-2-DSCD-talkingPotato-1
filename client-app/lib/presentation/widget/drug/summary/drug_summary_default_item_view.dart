import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/presentation/widget/common/image/network_image_view.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class DrugSummaryDefaultItemView extends StatelessWidget {
  const DrugSummaryDefaultItemView({
    super.key,
    required this.state,
  });

  final DrugSummaryState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          if (state.imageUrl == null)
            _buildEmptyImageView()
          else
            _buildDefaultImageView(),
          const SizedBox(width: 16),
          _buildTextView(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildEmptyImageView() {
    if (state.type == 'CUSTOM' || state.type == 'MEDICINE') {
      int idSum = state.id % 7;

      return SizedBox(
        width: 95,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const SvgImageView(
                assetPath: "assets/icons/drug_background.svg",
              ),
            ),
            Positioned(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  SvgImageView(
                    assetPath: 'assets/icons/medicine_$idSum.svg',
                    width: 38,
                  ),
                  const Spacer(),
                  SvgImageView(
                    assetPath: 'assets/icons/medicine_$idSum.svg',
                    width: 38,
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      );
    }

    int idSum = state.id % 2;

    return Container(
      width: 95,
      height: 95,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border.all(
          color: ColorSystem.neutral.shade50,
          width: 1,
        ),
      ),
      child: SvgImageView(assetPath: 'assets/icons/vitamin_$idSum.svg'),
    );
  }

  Widget _buildDefaultImageView() {
    if (state.type == 'CUSTOM') {
      throw Exception('Custom drug type must not have drug image url');
    }

    if (state.type == 'MEDICINE') {
      return NetworkImageView(
        imageUrl: state.imageUrl!,
        width: 95,
        height: 40,
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.white,
      );
    }

    return NetworkImageView(
      imageUrl: state.imageUrl!,
      width: 95,
      height: 95,
      borderRadius: BorderRadius.circular(16),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTextView() {
    return SizedBox(
      width: Get.width - 40 - 24 - 95,
      height: state.type == 'VITAMIN' ? 95 : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.type == 'VITAMIN'
                ? state.name
                : state.classificationOrManufacturer,
            overflow: TextOverflow.ellipsis,
            style: FontSystem.H5,
          ),
          Text(
            state.type == 'VITAMIN'
                ? state.classificationOrManufacturer
                : state.name,
            overflow: TextOverflow.ellipsis,
            style: FontSystem.Sub3.copyWith(
              color: ColorSystem.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
