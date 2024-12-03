import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';

class ScheduleHeaderView extends BaseWidget<MedicationViewModel> {
  const ScheduleHeaderView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Text(
      '오늘의 복약 기록들이에요',
      style: FontSystem.Sub2.copyWith(
        color: ColorSystem.neutral,
      ),
    );
  }
}
