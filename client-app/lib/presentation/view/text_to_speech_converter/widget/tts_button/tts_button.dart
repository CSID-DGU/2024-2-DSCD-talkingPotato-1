import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';

class TtsButton extends BaseWidget<TextToSpeechConverterViewModel> {
  const TtsButton({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Obx(
          () {
            Function()? onPressed;
            Widget child;

            onPressed = () {
              Function()? execute;

              if (viewModel.isSpeaking) {
                execute = viewModel.pauseSpeaking;
              } else {
                execute = viewModel.startSpeaking;
              }

              execute.call();
            };

            if (viewModel.isSpeaking) {
              child = Column(
                children: [
                  const SizedBox(height: 10.5),
                  Text(
                    "그만 듣기",
                    style: FontSystem.H5.copyWith(
                      color: ColorSystem.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10.5),
                ],
              );
            } else {
              child = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.isFirstSpeaking ? "목소리로 들어보기" : "다시 들어보기",
                    style: FontSystem.H5.copyWith(
                      color: ColorSystem.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "문장을 들을 수 있어요",
                    style: FontSystem.Sub2.copyWith(
                      color: ColorSystem.neutral.shade200,
                      height: 1.0,
                    ),
                  ),
                ],
              );
            }

            return OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                // Padding
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),

                // Size
                minimumSize: Size(Get.width * 0.6, 0),

                // Color
                backgroundColor: viewModel.isSpeaking
                    ? ColorSystem.secondary
                    : ColorSystem.secondary.shade600,
                foregroundColor: ColorSystem.white,

                // Shape
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

                // Border
                side: BorderSide(
                  color: ColorSystem.neutral.shade300,
                  width: 1,
                ),

                disabledBackgroundColor: ColorSystem.neutral.shade300,
              ),
              child: Center(
                child: child,
              ),
            );
          },
        ),
        const Spacer(),
      ],
    );
  }
}
