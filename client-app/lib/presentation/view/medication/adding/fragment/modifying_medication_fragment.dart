import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication/adding/widget/medication_card_for_adding/medication_card_for_adding_view.dart';
import 'package:wooahan/presentation/view/medication/adding/widget/medication_indicator_for_adding/medication_indicator_for_adding_view.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class ModifyingMedicationFragment
    extends BaseScreen<MedicationAddingViewModel> {
  const ModifyingMedicationFragment({super.key});

  @override
  Color get unSafeAreaColor => ColorSystem.white;

  @override
  Color? get screenBackgroundColor => ColorSystem.white;

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get setTopOuterSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          _buildDescriptionView(),
          const Spacer(),
          const MedicationIndicatorForAddingView(),
          const SizedBox(height: 16),
          const MedicationCardForAddingView(),
          const Spacer(),
          _buildConfirmButton(),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }

  Widget _buildDescriptionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '추가할 약들이예요',
          style: FontSystem.H2,
        ),
        const SizedBox(height: 8),
        Text(
          '알림을 받을 시간대를 선택해주세요.'
          '\n'
          '만약 삭제를 원한다면 약 사진을 꾹 눌러주세요.',
          style: FontSystem.Sub2.copyWith(
            color: ColorSystem.neutral.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return PrimaryFillButton(
      width: Get.width,
      height: 60,
      content: '완료',
      onPressed: () {
        viewModel.confirmApply().then(
          (value) {
            if (value) {
              viewModel.nextPage();
            } else {
              Get.snackbar(
                '알림',
                '추가에 실패했어요. 다시 시도해주세요.',
                backgroundColor: ColorSystem.primary,
                colorText: ColorSystem.white,
              );
            }
          },
        );
      },
    );
  }
}
