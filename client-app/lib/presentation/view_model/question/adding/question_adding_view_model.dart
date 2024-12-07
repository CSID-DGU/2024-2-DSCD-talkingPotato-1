import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/entity/stt/speech_to_text_state.dart';
import 'package:wooahan/domain/usecase/question/create_question_use_case.dart';

class QuestionAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final SpeechToText _speechToText;

  late final CreateQuestionUseCase _createQuestionUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late bool _isMadeByStt;

  late final RxBool _isLoading;
  late final RxString _content;

  late final RxBool _isStoppingSpeechToText;
  late final Rx<SpeechToTextState> _speechToTextState;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isLoading => _isLoading.value;
  String get content => _content.value;

  bool get isStoppingSpeechToText => _isStoppingSpeechToText.value;
  SpeechToTextState get speechToTextState => _speechToTextState.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _speechToText = SpeechToText();

    _createQuestionUseCase = Get.find<CreateQuestionUseCase>();

    _isMadeByStt = false;

    _isLoading = false.obs;
    _content = ''.obs;

    _isStoppingSpeechToText = false.obs;
    _speechToTextState = SpeechToTextState.initial().obs;
  }

  @override
  void onClose() {
    super.onClose();

    _speechToText.cancel();
  }

  void updateContent(String value) {
    _content.value = value;
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

      _content.value = '';
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
        _content.value = result.recognizedWords;
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

    _content.value = _speechToTextState.value.beforeSpeechText;

    _isMadeByStt = true;
    _isStoppingSpeechToText.value = false;
  }

  Future<bool> createQuestion() async {
    _isLoading.value = true;

    StateWrapper<void> result = await _createQuestionUseCase.execute(
      CreateQuestionCondition(
        content: content,
        isMadeByStt: _isMadeByStt,
      ),
    );

    await Get.find<BaseMediator>().publishCreateQuestionEvent();

    _isLoading.value = false;

    return result.success;
  }
}
