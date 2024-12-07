import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/medication/default/widget/schedule_card/component/schedule_card_item_view.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class ScheduleCardListView extends BaseWidget<MedicationViewModel> {
  const ScheduleCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        if (viewModel.isLoading || viewModel.isMoreLoading) {
          return const SizedBox();
        }

        if (viewModel.scheduleDetailList.isEmpty) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(
                '해당하는 복약 일정이 없어요!!',
                style: FontSystem.H5.copyWith(
                  color: ColorSystem.neutral.shade600,
                ),
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 120),
          itemCount: viewModel.scheduleDetailList.length,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
          itemBuilder: (context, index) {
            return ScheduleCardItemView(
              state: viewModel.scheduleDetailList[index],
              onTapContext: () {
                Get.toNamed(
                  "${AppRoutes.DRUG}/detail/${viewModel.scheduleDetailList[index].drugId}",
                  arguments: {
                    "type": viewModel.scheduleDetailList[index].drugType,
                  },
                );
              },
              onTapCheckbox: () {
                viewModel.updateIsTakenInScheduleDetail(index);
              },
            );
          },
        );
      },
    );
  }
}
