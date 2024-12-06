import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';

class MedicationIndicatorForAddingView
    extends BaseWidget<MedicationAddingViewModel> {
  const MedicationIndicatorForAddingView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 16,
        child: Center(
          child: AnimatedSmoothIndicator(
            activeIndex: viewModel.currentMedicationIndex,
            count: viewModel.newMedicationList.length,
            effect: WormEffect(
              dotColor: ColorSystem.neutral.shade400,
              activeDotColor: ColorSystem.primary,
            ),
          ),
        ),
      ),
    );
  }
}
