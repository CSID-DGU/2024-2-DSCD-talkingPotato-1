import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/widget/stt_button/stt_button.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class RecordingSpeechFragment
    extends BaseScreen<SpeechToTextConverterViewModel> {
  const RecordingSpeechFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ..._buildTitleViews(),
          const Spacer(),
          _buildContentView(),
          const SizedBox(height: 32),
          const SttButton(),
          const Spacer(),
          _buildButton(),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }

  List<Widget> _buildTitleViews() {
    return [
      const Text(
        '들어줄 목소리를 녹음해주세요',
        style: FontSystem.H2,
      ),
      SizedBox(height: 8),
      Text(
        '잡음이 적을수록 더 정확하게 들을 수 있어요\n'
        '녹음 중일 때는 아래 네모가 녹색으로 변해요.',
        style: FontSystem.Sub2.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
      ),
    ];
  }

  Widget _buildContentView() {
    return Obx(
      () {
        return Container(
          width: Get.width,
          height: Get.height * 0.4,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: viewModel.speechToTextState.isListening
                ? ColorSystem.primary.withOpacity(0.1)
                : ColorSystem.neutral.shade100,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Text(
              viewModel.speechToTextState.beforeSpeechText,
              style: FontSystem.H6,
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return Obx(() {
      if (viewModel.speechToTextState.isListening) {
        return PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: '목소리를 녹음하고 있어요',
          onPressed: null,
        );
      }

      return PrimaryFillButton(
        width: Get.width,
        height: 60,
        content: '다음',
        onPressed: viewModel.speechToTextState.beforeSpeechText.isNotEmpty &&
                viewModel.speechToTextState.isCompleted
            ? viewModel.analysisSpeech
            : null,
      );
    });
  }
}
