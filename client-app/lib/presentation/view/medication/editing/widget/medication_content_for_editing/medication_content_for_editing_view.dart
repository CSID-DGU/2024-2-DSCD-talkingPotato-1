import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/medication/editing/widget/medication_content_for_editing/component/editing_icon_button.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_view_model.dart';
import 'package:wooahan/presentation/widget/common/dialog/confirm_dialog.dart';
import 'package:wooahan/presentation/widget/medication/basic/medication_basic_default_item_view.dart';

class MedicationContentForEditingView
    extends BaseWidget<MedicationEditingViewModel> {
  const MedicationContentForEditingView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLeftButton(),
        _buildContentView(),
        _buildRightButton(),
      ],
    );
  }

  Widget _buildLeftButton() {
    return Obx(() {
      if (viewModel.isInitLoading) {
        return const SizedBox(width: 44);
      }

      if (viewModel.modifiedMedicationList.isEmpty) {
        return const SizedBox(width: 44);
      }

      if (viewModel.currentIndex != 0) {
        return EditingIconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 44,
          ),
          onTap: viewModel.decrementCurrentIndex,
        );
      } else {
        return const SizedBox(width: 44);
      }
    });
  }

  Widget _buildContentView() {
    return Obx(
      () {
        if (viewModel.isInitLoading) {
          return const Expanded(child: SizedBox());
        }

        if (viewModel.modifiedMedicationList.isEmpty) {
          return Text(
            '복약 중인 약이 없어요',
            style: FontSystem.H6.copyWith(
              height: 1.0,
              color: ColorSystem.neutral.shade500,
            ),
          );
        }

        return MedicationBasicDefaultItemView(
          state: viewModel.modifiedMedicationList[viewModel.currentIndex],
          onLongPress: () {
            Get.dialog(
              ConfirmDialog(
                title: "복약 삭제",
                content: '해당 약을 지우시겠어요?'
                    '\n'
                    '삭제 시 알림을 받을 수 없어요.',
                onPressedCancel: Get.back,
                onPressedApply: () {
                  viewModel.removeMedication(viewModel.currentIndex);
                  Get.back();
                },
              ),
            );
          },
          onTapBreakfast: () {
            viewModel.updateIsTakenInMedication(
              viewModel.currentIndex,
              'breakfast',
            );
          },
          onTapLunch: () {
            viewModel.updateIsTakenInMedication(
              viewModel.currentIndex,
              'lunch',
            );
          },
          onTapDinner: () {
            viewModel.updateIsTakenInMedication(
              viewModel.currentIndex,
              'dinner',
            );
          },
          onTapDaily: () {
            viewModel.updateIsTakenInMedication(
              viewModel.currentIndex,
              'daily',
            );
          },
        );
      },
    );
  }

  Widget _buildRightButton() {
    return Obx(() {
      if (viewModel.isInitLoading) {
        return const SizedBox(width: 44);
      }

      if (viewModel.modifiedMedicationList.isEmpty) {
        return const SizedBox(width: 44);
      }

      if (viewModel.currentIndex !=
          viewModel.modifiedMedicationList.length - 1) {
        return EditingIconButton(
          icon: const Icon(
            Icons.chevron_right,
            size: 44,
          ),
          onTap: viewModel.incrementCurrentIndex,
        );
      } else {
        return const SizedBox(width: 44);
      }
    });
  }
}
