import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/correction/correct_speech_text_condition.dart';
import 'package:wooahan/domain/entity/stt/speech_to_text_state.dart';
import 'package:wooahan/domain/usecase/correction/correct_speech_text_use_case.dart';

class SpeechToTextConverterViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final PageController pageController;

  late final SpeechToText _speechToText;

  late final CorrectSpeechTextUseCase _correctSpeechTextUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxnString _recordedSpeech;

  late final RxBool _isStoppingSpeechToText;
  late final Rx<SpeechToTextState> _speechToTextState;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String? get recordedSpeech => _recordedSpeech.value;

  bool get isStoppingSpeechToText => _isStoppingSpeechToText.value;
  SpeechToTextState get speechToTextState => _speechToTextState.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: 0);

    _speechToText = SpeechToText();

    _correctSpeechTextUseCase = Get.find<CorrectSpeechTextUseCase>();

    _recordedSpeech = RxnString();

    _isStoppingSpeechToText = false.obs;
    _speechToTextState = SpeechToTextState.initial().obs;
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
    _isStoppingSpeechToText.value = true;

    await _speechToText.stop();

    _speechToTextState.value = _speechToTextState.value.copyWith(
      isListening: false,
      isCompleted: true,
    );

    _isStoppingSpeechToText.value = false;
  }

  void analysisSpeech() async {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    StateWrapper<String> result = await _correctSpeechTextUseCase.execute(
      CorrectSpeechTextCondition(
        content: _speechToTextState.value.beforeSpeechText,
      ),
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
