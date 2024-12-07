import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/setting/setting_view_model.dart';

class TimeSectionView extends BaseWidget<SettingViewModel> {
  const TimeSectionView({
    super.key,
    required this.title,
    required this.hour,
    required this.minute,
    required this.onTap,
  });

  final String title;
  final int hour;
  final int minute;
  final Function() onTap;

  @override
  Widget buildView(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.only(left: 20, right: 12),
        child: Row(
          children: [
            Text(
              title,
              style: FontSystem.Sub2,
            ),
            const Spacer(),
            Text(
              "$hour:${minute.toString().padLeft(2, '0')}",
              style: FontSystem.Sub3.copyWith(
                color: ColorSystem.neutral.shade600,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: ColorSystem.neutral.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
