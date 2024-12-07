import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class FinishMedicationFragment extends BaseScreen<MedicationAddingViewModel> {
  const FinishMedicationFragment({super.key});

  @override
  Color? get screenBackgroundColor => ColorSystem.white;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setTopInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ..._buildTitleViews(),
          const Spacer(),
          Center(
            child: SvgPicture.asset(
              "assets/icons/complete.svg",
              width: 250,
            ),
          ),
          const Spacer(),
          _buildNextButton(),
        ],
      ),
    );
  }

  List<Widget> _buildTitleViews() {
    return [
      const Text(
        "알림 받을 약들을 추가했어요!",
        style: FontSystem.H1,
      ),
      const SizedBox(height: 4),
      Text(
        "설정한 시간대에 알림을 받을 예정이에요.",
        style: FontSystem.H6.copyWith(
          color: ColorSystem.neutral.shade600,
        ),
      ),
    ];
  }

  Widget _buildNextButton() {
    return Container(
      width: Get.width,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: PrimaryFillButton(
        width: Get.width,
        height: 60,
        content: '돌아가기',
        onPressed: Get.back,
      ),
    );
  }
}
