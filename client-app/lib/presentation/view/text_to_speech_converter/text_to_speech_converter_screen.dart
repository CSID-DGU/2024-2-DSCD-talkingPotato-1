import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/fragment/complete_text_analysis_fragment.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/fragment/loading_text_analysis_fragment.dart';
import 'package:wooahan/presentation/view/text_to_speech_converter/fragment/selecting_picture_fragment.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class TextToSpeechConverterScreen
    extends BaseScreen<TextToSpeechConverterViewModel> {
  const TextToSpeechConverterScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '문서 읽어주기',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      children: const [
        SelectingPictureFragment(),
        LoadingTextAnalysisFragment(),
        CompleteTextAnalysisFragment(),
      ],
    );
  }
}
