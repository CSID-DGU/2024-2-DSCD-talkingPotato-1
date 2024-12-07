import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/setting/setting_view_model.dart';

class ToggleSectionView extends BaseWidget<SettingViewModel> {
  const ToggleSectionView({
    super.key,
    required this.title,
    required this.content,
    required this.isActive,
    required this.onChanged,
  });

  final String title;
  final String content;
  final bool isActive;
  final Function(bool) onChanged;

  @override
  Widget buildView(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLeftView(),
          _buildRightView(),
        ],
      ),
    );
  }

  Widget _buildLeftView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontSystem.H5.copyWith(
            color: ColorSystem.neutral.shade900,
          ),
        ),
        Text(
          content,
          style: FontSystem.Sub3.copyWith(
            color: ColorSystem.neutral,
          ),
        ),
      ],
    );
  }

  Widget _buildRightView() {
    return SizedBox(
      width: 60,
      height: 30,
      child: Switch(
        value: isActive,
        onChanged: onChanged,
        activeColor: ColorSystem.white,
        activeTrackColor: ColorSystem.primary.shade300,
        inactiveThumbColor: ColorSystem.white,
        inactiveTrackColor: ColorSystem.neutral.shade300,
        trackOutlineColor: WidgetStateProperty.all(ColorSystem.transparent),
      ),
    );
  }
}
