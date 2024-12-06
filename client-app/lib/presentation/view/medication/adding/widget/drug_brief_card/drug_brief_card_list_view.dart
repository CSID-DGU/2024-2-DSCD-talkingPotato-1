import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/drug/brief/drug_brief_default_item_view.dart';

class DrugBriefCardListView extends BaseWidget<MedicationAddingViewModel> {
  const DrugBriefCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (viewModel.isLoadingSearching) {
            return const SizedBox(
              height: 120,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorSystem.primary),
                ),
              ),
            );
          }

          if (viewModel.drugBriefList.isEmpty &&
              viewModel.searchTerm.isNotEmpty) {
            return Center(
              child: Text(
                "검색 결과가 없습니다.",
                style: FontSystem.H6.copyWith(
                  color: ColorSystem.neutral.shade600,
                ),
              ),
            );
          } else if (viewModel.drugBriefList.isEmpty &&
              viewModel.searchTerm.isEmpty) {
            return Container(
              color: ColorSystem.white,
            );
          }

          return _buildDefault();
        },
      ),
    );
  }

  Widget _buildDefault() {
    return ListView.builder(
      itemCount: viewModel.drugBriefList.length,
      itemBuilder: (context, index) {
        return Obx(
          () {
            return DrugBriefDefaultItemView(
              state: viewModel.drugBriefList[index],
              onTapContext: () {
                Get.toNamed(
                  "${AppRoutes.DRUG}/detail/${viewModel.drugBriefList[index].id}",
                  arguments: {
                    "type": viewModel.drugBriefList[index].type,
                  },
                );
              },
              onTapPlus: () {
                viewModel.addDrugSummary(index).then((value) {
                  if (value) {
                    Get.snackbar(
                      "알림",
                      "복약 장바구니에 추가되었습니다.",
                      backgroundColor: ColorSystem.neutral.withOpacity(0.2),
                      colorText: ColorSystem.black,
                      duration: const Duration(milliseconds: 1000),
                    );
                  } else {
                    Get.snackbar(
                      "알림",
                      "이미 추가된 약입니다.",
                      backgroundColor: ColorSystem.neutral.withOpacity(0.2),
                      colorText: ColorSystem.black,
                      duration: const Duration(milliseconds: 1000),
                    );
                  }
                });
              },
            );
          },
        );
      },
    );
  }
}
