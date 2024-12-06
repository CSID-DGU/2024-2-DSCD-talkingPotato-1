import 'package:get/get.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/usecase/question/create_question_use_case.dart';

class QuestionAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final CreateQuestionUseCase _createQuestionUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;
  late final RxString _content;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isLoading => _isLoading.value;
  String get content => _content.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _createQuestionUseCase = Get.find<CreateQuestionUseCase>();

    _isLoading = false.obs;
    _content = ''.obs;
  }

  void updateContent(String value) {
    _content.value = value;
  }

  Future<bool> createQuestion() async {
    _isLoading.value = true;

    StateWrapper<void> result = await _createQuestionUseCase.execute(
      CreateQuestionCondition(
        content: content,
        isMadeByStt: false,
      ),
    );

    await Get.find<BaseMediator>().publishCreateQuestionEvent();

    _isLoading.value = false;

    return result.success;
  }
}
