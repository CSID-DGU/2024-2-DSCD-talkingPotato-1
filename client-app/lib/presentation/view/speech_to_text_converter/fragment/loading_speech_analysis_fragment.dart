import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/animation/rive_animation_view.dart';

class LoadingSpeechAnalysisFragment
    extends BaseScreen<SpeechToTextConverterViewModel> {
  const LoadingSpeechAnalysisFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: Get.height * 0.5,
            child: const RiveAnimationView(
              assetName: 'assets/animations/loading.riv',
              artboardName: 'none_stop',
              autoplay: true,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: Center(
            child: DefaultTextStyle(
              style: FontSystem.H6,
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText(
                    '목소리를 교정 중이예요\n잠시만 기다려주세요',
                    textAlign: TextAlign.center,
                    duration: const Duration(seconds: 2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
