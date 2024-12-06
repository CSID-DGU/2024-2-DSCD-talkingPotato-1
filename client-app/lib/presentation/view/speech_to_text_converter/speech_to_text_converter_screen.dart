import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/fragment/complete_speech_analysis_fragment.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/fragment/loading_speech_analysis_fragment.dart';
import 'package:wooahan/presentation/view/speech_to_text_converter/fragment/recording_speech_fragment.dart';
import 'package:wooahan/presentation/view_model/speech_to_text_converter/speech_to_text_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class SpeechToTextConverterScreen
    extends BaseScreen<SpeechToTextConverterViewModel> {
  const SpeechToTextConverterScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '목소리 들어주기',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      children: const [
        RecordingSpeechFragment(),
        LoadingSpeechAnalysisFragment(),
        CompleteSpeechAnalysisFragment(),
      ],
    );
  }
}
