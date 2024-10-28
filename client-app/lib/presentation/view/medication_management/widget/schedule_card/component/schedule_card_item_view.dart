import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/schedule_overview_state.dart';
import 'package:wooahan/presentation/widget/image/network_image_view.dart';
import 'package:wooahan/presentation/widget/image/svg_image_view.dart';

class ScheduleCardItemView extends StatelessWidget {
  const ScheduleCardItemView({
    super.key,
    required this.state,
    required this.onTapContext,
    required this.onTapCheckbox,
  });

  final ScheduleOverviewState state;
  final Function() onTapContext;
  final Function() onTapCheckbox;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapContext,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorSystem.white,
          boxShadow: [
            BoxShadow(
              color: ColorSystem.neutral.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            if (state.drugImageUrl == null)
              _buildEmptyImageView()
            else
              _buildDefaultImageView(),
            const SizedBox(width: 16),
            _buildTextView(),
            const SizedBox(width: 8),
            _buildCheckBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyImageView() {
    if (state.drugType == 'CUSTOM' ||
        state.drugType == 'ETC_MEDICINE' ||
        state.drugType == 'OTC_MEDICINE') {
      int idSum = state.id % 7;

      return Container(
        width: 95,
        height: 40,
        margin: const EdgeInsets.only(top: 6),
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
    if (state.drugType == 'CUSTOM') {
      throw Exception('Custom drug type must not have drug image url');
    }

    if (state.drugType == 'ETC_MEDICINE' || state.drugType == 'OTC_MEDICINE') {
      return NetworkImageView(
        imageUrl: state.drugImageUrl!,
        width: 95,
        height: 40,
        borderRadius: BorderRadius.circular(8),
        backgroundColor: Colors.white,
      ).marginOnly(top: 6);
    }

    return NetworkImageView(
      imageUrl: state.drugImageUrl!,
      width: 95,
      height: 95,
      borderRadius: BorderRadius.circular(16),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTextView() {
    return SizedBox(
      width: Get.width - 40 - 24 - 164,
      height: state.drugType == 'VITAMIN' ? 95 : null,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.drugClassificationOrManufacturer ?? '미등록 약품',
            overflow: TextOverflow.ellipsis,
            style: FontSystem.H4,
          ),
          Text(
            state.drugName,
            overflow: TextOverflow.ellipsis,
            style: FontSystem.Sub2.copyWith(
              color: ColorSystem.neutral.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBox() {
    return GestureDetector(
      onTap: onTapCheckbox,
      child: SvgImageView(
        assetPath: state.isTaken
            ? 'assets/icons/checkbox_active.svg'
            : 'assets/icons/checkbox_inactive.svg',
        width: 36,
      ),
    );
  }
}
