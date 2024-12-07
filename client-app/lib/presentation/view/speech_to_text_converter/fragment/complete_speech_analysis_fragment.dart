import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class CompleteSpeechAnalysisFragment
    extends BaseScreen<SpeechToTextConverterViewModel> {
  const CompleteSpeechAnalysisFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          const Text(
            '목소리 교정이 완료되었어요',
            style: FontSystem.H2,
          ),
          Text(
            '아래에 교정된 내용이예요',
            style: FontSystem.Sub2.copyWith(
              color: ColorSystem.neutral.shade700,
            ),
          ),
          const Spacer(),
          Obx(
            () => Container(
              width: Get.width,
              height: Get.height * 0.5,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: viewModel.speechToTextState.isListening
                    ? ColorSystem.primary.withOpacity(0.1)
                    : ColorSystem.neutral.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Text(
                  viewModel.speechToTextState.afterSpeechText,
                  style: FontSystem.H6,
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
