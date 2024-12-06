import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class CompleteTextAnalysisFragment
    extends BaseScreen<TextToSpeechConverterViewModel> {
  const CompleteTextAnalysisFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            '사진 분석이 완료되었어요',
            style: FontSystem.H2,
          ),
          Text(
            '입술 모양을 눌러 들어보세요',
            style: FontSystem.Sub2.copyWith(
              color: ColorSystem.neutral.shade700,
            ),
          ),
          const Spacer(),
          Image.file(
            File(viewModel.image!.path),
            width: Get.width,
            height: Get.height * 0.45,
            fit: BoxFit.cover,
          ),
          const Spacer(),
          Center(
            child: Obx(
              () => FilledButton(
                onPressed: viewModel.updateListening,
                style: FilledButton.styleFrom(
                  // Padding
                  padding: EdgeInsets.zero,

                  // Size
                  minimumSize: const Size(64, 64),
                  fixedSize: const Size(64, 64),

                  elevation: 1,

                  // Color
                  backgroundColor: ColorSystem.secondary,
                  foregroundColor: ColorSystem.white,

                  disabledBackgroundColor: ColorSystem.neutral.shade300,

                  // Border
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32),
                    ),
                  ),
                ),
                child: viewModel.isListening
                    ? const Icon(
                        Icons.stop,
                        size: 40,
                      )
                    : const SvgImageView(
                        assetPath: 'assets/icons/lips.svg',
                        width: 40,
                      ),
              ),
            ),
          ),
          const Spacer(),
          PrimaryFillButton(
            width: Get.width,
            height: 64,
            content: '완료',
            onPressed: Get.back,
          ),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }
}
