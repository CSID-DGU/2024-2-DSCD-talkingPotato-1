import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class ScheduleHeaderView extends BaseWidget<MedicationViewModel> {
  const ScheduleHeaderView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Center(
      child: Obx(
        () {
          if (viewModel.selectedTimeline == 'daily') {
            return Text(
              '오늘 알림을 받지 않은 약들이에요',
              style: FontSystem.Sub2.copyWith(
                color: ColorSystem.neutral,
              ),
            );
          }

          String? timelineStr;

          switch (viewModel.selectedTimeline) {
            case 'breakfast':
              timelineStr = '아침';
              break;
            case 'lunch':
              timelineStr = '점심';
              break;
            case 'dinner':
              timelineStr = '저녁';
              break;
          }

          return Text(
            '오늘 $timelineStr에 복약할 약들이에요',
            style: FontSystem.Sub2.copyWith(
              color: ColorSystem.neutral,
            ),
          );
        },
      ),
    );
  }
}
