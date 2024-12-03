import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/medication/default/widget/schedule_card/component/schedule_card_item_view.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class ScheduleCardListView extends BaseWidget<MedicationViewModel> {
  const ScheduleCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: viewModel.scheduleDetailList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 20);
        },
        itemBuilder: (context, index) {
          return ScheduleCardItemView(
            state: viewModel.scheduleDetailList[index],
            onTapContext: () {
              if (viewModel.scheduleDetailList[index].drugId == null) {
                Get.snackbar(
                  '약품 정보가 없습니다.',
                  '미등록 약품은 상세정보를 확인할 수 없습니다.',
                  duration: const Duration(seconds: 2),
                );

                return;
              }

              Get.toNamed(
                "${AppRoutes.DRUG}/detail/${viewModel.scheduleDetailList[index].drugId}",
                arguments: {
                  "type": viewModel.scheduleDetailList[index].drugType,
                },
              );
            },
            onTapCheckbox: () {
              viewModel.updateIsTakenInScheduleDetailList(
                viewModel.scheduleDetailList[index].drugName,
              );
            },
          );
        },
      ),
    );
  }
}
