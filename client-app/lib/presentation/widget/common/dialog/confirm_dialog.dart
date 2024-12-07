import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressedCancel,
    required this.onPressedApply,
  });

  final String title;
  final String content;
  final Function() onPressedCancel;
  final Function() onPressedApply;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: Get.width * 0.8,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: ColorSystem.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleView(),
            const SizedBox(height: 8.0),
            _buildContentView(),
            const SizedBox(height: 32.0),
            _buildButtonView(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleView() {
    return Text(
      title,
      style: FontSystem.H3,
    );
  }

  Widget _buildContentView() {
    return Text(
      content,
      style: FontSystem.Sub3,
    );
  }

  Widget _buildButtonView() {
    return Row(
      children: [
        FilledButton(
          onPressed: onPressedCancel,
          style: FilledButton.styleFrom(
            // Size
            minimumSize: Size(
              (Get.width * 0.8 - 60) / 2,
              52,
            ),
            maximumSize: Size(
              (Get.width * 0.8 - 60) / 2,
              52,
            ),

            // Color
            backgroundColor: ColorSystem.neutral.shade200,
            foregroundColor: ColorSystem.white,

            disabledBackgroundColor: ColorSystem.neutral.shade300,

            // Border
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          child: Center(
            child: Text(
              "취소",
              style: FontSystem.H5.copyWith(
                color: ColorSystem.neutral,
                height: 1.0,
              ),
            ),
          ),
        ),
        const Spacer(),
        FilledButton(
          onPressed: onPressedApply,
          style: FilledButton.styleFrom(
            minimumSize: Size(
              (Get.width * 0.8 - 60) / 2,
              52,
            ),
            maximumSize: Size(
              (Get.width * 0.8 - 60) / 2,
              52,
            ),

            backgroundColor: ColorSystem.red.shade400,
            foregroundColor: ColorSystem.white,

            disabledBackgroundColor: ColorSystem.neutral.shade300,

            // Border
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ),
          child: Center(
            child: Text(
              "확인",
              style: FontSystem.H5.copyWith(
                color: ColorSystem.white,
                height: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
