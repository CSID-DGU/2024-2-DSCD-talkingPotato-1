import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/view/medication/adding/widget/drug_brief_card/drug_brief_card_list_view.dart';
import 'package:wooahan/presentation/view/medication/adding/widget/drug_search_term_field/drug_search_term_field.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class SearchingDrugFragment extends GetView<MedicationAddingViewModel> {
  const SearchingDrugFragment({super.key});

  MedicationAddingViewModel get viewModel => controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          _buildContentLayer(),
          _buildButtonLayer(),
        ],
      ),
    );
  }

  Widget _buildContentLayer() {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorSystem.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DrugSearchTermField(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InfinityHorizonLine(
              gap: 1,
              color: ColorSystem.neutral.shade200,
            ),
          ),
          const DrugBriefCardListView(),
          SizedBox(height: GetPlatform.isAndroid ? 80 : 100),
        ],
      ),
    );
  }

  Widget _buildButtonLayer() {
    return Obx(
      () {
        bool isExistDrug = viewModel.drugSummaryList.isNotEmpty;

        return Positioned(
          right: 20,
          bottom: GetPlatform.isAndroid ? 20 : 40,
          child: PrimaryFillButton(
            width: Get.width - 40,
            height: 60,
            content: isExistDrug ? '다음' : '추가할 약이 없어요',
            onPressed: isExistDrug
                ? () {
                    viewModel.convertDrugSummaryToMedication();
                    viewModel.nextPage();
                  }
                : null,
          ),
        );
      },
    );
  }
}
