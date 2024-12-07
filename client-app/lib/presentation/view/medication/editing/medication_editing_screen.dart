import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication/editing/widget/medication_content_for_editing/medication_content_for_editing_view.dart';
import 'package:wooahan/presentation/view/medication/editing/widget/medication_indicator_for_editing/medication_indicator_for_editing_view.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/dialog/confirm_dialog.dart';

class MedicationEditingScreen extends BaseScreen<MedicationEditingViewModel> {
  const MedicationEditingScreen({super.key});

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
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      title: '복약 수정하기',
      backgroundColor: ColorSystem.white,
      onBackPress: Get.back,
      actions: [
        GestureDetector(
          onTap: () {
            Get.dialog(
              ConfirmDialog(
                title: "복약 삭제",
                content: '해당 약을 지우시겠어요?'
                    '\n'
                    '삭제 시 알림을 받을 수 없어요.',
                onPressedCancel: Get.back,
                onPressedApply: () {
                  viewModel.deleteAllApply().then((value) {
                    if (value) {
                      Get.back();
                    } else {
                      Get.snackbar(
                        '알림',
                        '전체 삭제에 실패했어요. 다시 시도해주세요.',
                        backgroundColor: ColorSystem.primary,
                        colorText: ColorSystem.white,
                      );
                    }
                  });
                },
              ),
            );
          },
          child: Text(
            '전체 삭제',
            style: FontSystem.Sub1.copyWith(
              color: ColorSystem.red,
            ),
          ),
        ),
        const SizedBox(width: 20),
      ],
      preferredSize: const Size.fromHeight(64),
    );
  }

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
          const MedicationIndicatorForEditingView(),
          const SizedBox(height: 16),
          const MedicationContentForEditingView(),
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
          '현재 복용 중인 약들이예요',
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
    return Obx(() {
      if (!viewModel.isEdited) {
        return const SizedBox(height: 60);
      }

      return PrimaryFillButton(
        width: Get.width,
        height: 60,
        content: '수정하기',
        onPressed: () {
          viewModel.confirmApply().then(
            (value) {
              if (value) {
                Get.back();
              } else {
                Get.snackbar(
                  '알림',
                  '수정에 실패했어요. 다시 시도해주세요.',
                  backgroundColor: ColorSystem.primary,
                  colorText: ColorSystem.white,
                );
              }
            },
          );
        },
      );
    });
  }
}
