import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/widget/tts_button/tts_button.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

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
          ..._buildDescriptionViews(),
          const Spacer(),
          _buildAnalysisResultView(),
          const SizedBox(height: 32),
          const TtsButton(),
          const Spacer(),
          _buildCompleteButton(),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }

  List<Widget> _buildDescriptionViews() {
    return [
      const Text(
        '사진 분석이 완료되었어요',
        style: FontSystem.H2,
      ),
      Text(
        '버튼을 눌러 들어보세요',
        style: FontSystem.Sub2.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
      ),
    ];
  }

  Widget _buildAnalysisResultView() {
    return GestureDetector(
      onTap: viewModel.updateViewing,
      child: Obx(() {
        if (viewModel.isViewingImage) {
          return Image.file(
            File(viewModel.image!.path),
            width: Get.width,
            height: Get.height * 0.4,
            fit: BoxFit.cover,
          );
        }

        return Container(
          width: Get.width,
          height: Get.height * 0.4,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorSystem.neutral.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: SingleChildScrollView(
            child: Text(
              viewModel.analysisResult,
              style: FontSystem.Sub3,
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCompleteButton() {
    return Obx(() {
      return PrimaryFillButton(
        width: Get.width,
        height: 64,
        content: viewModel.isSpeaking ? '음성으로 듣고 있어요' : '돌아가기',
        onPressed: viewModel.isSpeaking ? null : Get.back,
      );
    });
  }
}
