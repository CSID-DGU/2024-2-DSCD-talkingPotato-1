import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/medication/adding/widget/medication_card_for_adding/component/adding_icon_button.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/dialog/confirm_dialog.dart';
import 'package:wooahan/presentation/widget/medication/basic/medication_basic_default_item_view.dart';

class MedicationCardForAddingView
    extends BaseWidget<MedicationAddingViewModel> {
  const MedicationCardForAddingView({super.key});

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
      if (viewModel.currentMedicationIndex != 0) {
        return AddingIconButton(
          icon: const Icon(
            Icons.chevron_left,
            size: 48,
          ),
          onTap: viewModel.decrementCurrentIndex,
        );
      } else {
        return const SizedBox(width: 48);
      }
    });
  }

  Widget _buildContentView() {
    return Obx(
      () => MedicationBasicDefaultItemView(
        state: viewModel.newMedicationList[viewModel.currentMedicationIndex],
        onLongPress: () {
          Get.dialog(
            ConfirmDialog(
              title: "해당 약을 추가하지 않을까요?",
              content: '',
              onPressedCancel: Get.back,
              onPressedApply: () {
                viewModel.removeMedication(viewModel.currentMedicationIndex);
                Get.back();
              },
            ),
          );
        },
        onTapBreakfast: () {
          viewModel.updateIsTakenInMedication(
            viewModel.currentMedicationIndex,
            'breakfast',
          );
        },
        onTapLunch: () {
          viewModel.updateIsTakenInMedication(
            viewModel.currentMedicationIndex,
            'lunch',
          );
        },
        onTapDinner: () {
          viewModel.updateIsTakenInMedication(
            viewModel.currentMedicationIndex,
            'dinner',
          );
        },
        onTapDaily: () {
          viewModel.updateIsTakenInMedication(
            viewModel.currentMedicationIndex,
            'daily',
          );
        },
      ),
    );
  }

  Widget _buildRightButton() {
    return Obx(() {
      if (viewModel.currentMedicationIndex !=
          viewModel.newMedicationList.length - 1) {
        return AddingIconButton(
          icon: const Icon(
            Icons.chevron_right,
            size: 48,
          ),
          onTap: viewModel.incrementCurrentIndex,
        );
      } else {
        return const SizedBox(width: 48);
      }
    });
  }
}
