import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/entity/stt/speech_to_text_state.dart';
import 'package:wooahan/domain/usecase/comment/create_article_comment_use_case.dart';

class CommentAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int articleId;

  late final SpeechToText _speechToText;

  late final CreateArticleCommentUseCase _createArticleCommentUseCase;

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

    articleId = Get.arguments['id'];

    _speechToText = SpeechToText();

    _createArticleCommentUseCase = Get.find<CreateArticleCommentUseCase>();

    _isMadeByStt = false;

    _isLoading = false.obs;
    _content = ''.obs;

    _isStoppingSpeechToText = false.obs;
    _speechToTextState = SpeechToTextState.initial().obs;
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

  Future<bool> createComment() async {
    _isLoading.value = true;

    StateWrapper<void> result = await _createArticleCommentUseCase.execute(
      CreateArticleCommentCondition(
        articleId: articleId,
        content: _content.value,
        isMadeByStt: _isMadeByStt,
      ),
    );

    await Get.find<BaseMediator>().publishCreateArticleCommentEvent(articleId);

    _isLoading.value = false;

    return result.success;
  }
}
