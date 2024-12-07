import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_view_model.dart';

class QuestionSpeechButton extends BaseWidget<QuestionAddingViewModel> {
  const QuestionSpeechButton({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Obx(
          () {
            Function()? onPressed;
            Widget child;

            if (viewModel.isStoppingSpeechToText) {
              onPressed = null;
            } else {
              onPressed = () {
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
              };
            }

            if (viewModel.isStoppingSpeechToText) {
              child = Column(
                children: [
                  const SizedBox(height: 10.5),
                  Text(
                    "녹음 종료 중...",
                    style: FontSystem.H5.copyWith(
                      color: ColorSystem.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 10.5),
                ],
              );
            } else if (viewModel.speechToTextState.isListening) {
              child = Column(
                children: [
                  const SizedBox(height: 10.5),
                  Text(
                    "녹음 끝내기",
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
                    "목소리로 입력하기",
                    style: FontSystem.H5.copyWith(
                      color: ColorSystem.white,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "음성으로 입력할 수 있어요",
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
                backgroundColor: viewModel.speechToTextState.isListening
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
