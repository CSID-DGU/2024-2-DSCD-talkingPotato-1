import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_view_model.dart';
import 'package:wooahan/presentation/widget/button/primary/primary_fill_button.dart';

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
        String? recordedSpeech;

        if (viewModel.speechToTextState.isFirstListening) {
          recordedSpeech = '네모를 누를 시 녹음이 시작됩니다.';
        } else if (viewModel.speechToTextState.isListening) {
          recordedSpeech = '녹음 중 입니다... 지금 네모를 누르면 녹음이 멈춰요.';
        } else if (viewModel.speechToTextState.isCompleted) {
          recordedSpeech = '녹음이 완료되었습니다. 네모를 누를 시 다시 녹음할 수 있어요.';
        }

        return GestureDetector(
          onTap: () async {
            Function()? execute;

            if (viewModel.speechToTextState.isListening) {
              execute = viewModel.stopListening;
            } else {
              execute = () async {
                bool isAvailable =
                    await viewModel.checkSpeechToTextAvailability();

                if (!isAvailable) {
                  Get.snackbar(
                    '권한 오류',
                    '마이크 권한을 허용해주세요.',
                    backgroundColor:
                        ColorSystem.neutral.shade500.withOpacity(0.8),
                    colorText: ColorSystem.black,
                  );
                } else {
                  viewModel.startListening();
                }
              };
            }

            execute.call();
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.45,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: viewModel.speechToTextState.isListening
                  ? ColorSystem.primary.withOpacity(0.1)
                  : ColorSystem.neutral.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    recordedSpeech!,
                    style: FontSystem.Sub3.copyWith(
                      color: ColorSystem.neutral.shade500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Text(
                    viewModel.speechToTextState.beforeSpeechText,
                    style: FontSystem.Sub3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildButton() {
    return Obx(
      () => PrimaryFillButton(
        width: Get.width,
        height: 64,
        content: '문서로 보여주세요',
        onPressed: viewModel.speechToTextState.beforeSpeechText.isNotEmpty &&
                viewModel.speechToTextState.isCompleted
            ? viewModel.analysisSpeech
            : null,
      ),
    );
  }
}
