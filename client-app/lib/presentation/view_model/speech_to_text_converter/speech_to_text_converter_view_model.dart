import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_speech_condition.dart';
import 'package:wooahan/domain/entity/stt/speech_to_text_state.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_speech_use_case.dart';

class SpeechToTextConverterViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final PageController pageController;
  late final SpeechToText _speechToText;

  late final AnalysisSpeechUseCase _analysisSpeechUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rx<SpeechToTextState> _speechToTextState;
  late final RxnString _recordedSpeech;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  SpeechToTextState get speechToTextState => _speechToTextState.value;
  String? get recordedSpeech => _recordedSpeech.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();


    _analysisSpeechUseCase = Get.find<AnalysisSpeechUseCase>();

    pageController = PageController(initialPage: 0);
    _speechToText = SpeechToText();

    _speechToTextState = SpeechToTextState.initial().obs;
    _recordedSpeech = RxnString();
  }

  Future<bool> checkSpeechToTextAvailability() async {
    bool isAvailable = await _speechToText.initialize();

    if (isAvailable) {
      _speechToTextState.value = _speechToTextState.value.copyWith(
        isFirstListening: false,
        isListening: false,
        isCompleted: false,
        beforeSpeechText: '',
        afterSpeechText: '',
      );
    }

    return isAvailable;
  }

  void startListening() async {
    _speechToTextState.value = _speechToTextState.value.copyWith(
      isListening: true,
    );

    await _speechToText.listen(
      onResult: (result) async {
        _speechToTextState.value = _speechToTextState.value.copyWith(
          beforeSpeechText: result.recognizedWords,
        );
      },
      localeId: 'ko_KR',
    );
  }

  Future<void> stopListening() async {
    await _speechToText.stop();

    _speechToTextState.value = _speechToTextState.value.copyWith(
      isListening: false,
      isCompleted: true,
    );
  }

  void analysisSpeech() async {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    StateWrapper<String> result = await _analysisSpeechUseCase.execute(
      AnalysisSpeechCondition(text: _speechToTextState.value.beforeSpeechText),
    );

    if (result.success) {
      _speechToTextState.value = _speechToTextState.value.copyWith(
        afterSpeechText: result.data!,
      );
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
