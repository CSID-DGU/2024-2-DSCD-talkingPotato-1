import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wooahan/domain/entity/stt/speech_to_text_state.dart';

class SpeechToTextConverterViewModel extends GetxController {
  late final PageController pageController;
  late final SpeechToText _speechToText;

  late final Rx<SpeechToTextState> _speechToTextState;
  late final RxnString _recordedSpeech;

  SpeechToTextState get speechToTextState => _speechToTextState.value;
  String? get recordedSpeech => _recordedSpeech.value;

  @override
  void onInit() {
    super.onInit();

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
    // 1. 페이지 이동
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // 2. API 요청
    await Future.delayed(const Duration(seconds: 4));
    _speechToTextState.value = _speechToTextState.value.copyWith(
      afterSpeechText: _speechToTextState.value.beforeSpeechText,
    );

    // 3. 페이지 이동
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
