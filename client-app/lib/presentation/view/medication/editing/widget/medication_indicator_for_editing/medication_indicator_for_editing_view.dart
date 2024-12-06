import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_view_model.dart';

class MedicationIndicatorForEditingView
    extends BaseWidget<MedicationEditingViewModel> {
  const MedicationIndicatorForEditingView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        if (viewModel.isInitLoading) {
          return const SizedBox(height: 16);
        }

        if (viewModel.modifiedMedicationList.isEmpty) {
          return const SizedBox(height: 16);
        }

        return SizedBox(
          height: 16,
          child: Center(
            child: AnimatedSmoothIndicator(
              activeIndex: viewModel.currentIndex,
              count: viewModel.modifiedMedicationList.length,
              effect: WormEffect(
                dotColor: ColorSystem.neutral.shade400,
                activeDotColor: ColorSystem.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}
