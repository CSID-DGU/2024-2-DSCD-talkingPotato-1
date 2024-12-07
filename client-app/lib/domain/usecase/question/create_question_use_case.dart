import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/correction/correct_speech_text_condition.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/repository/correction/correction_repository.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class CreateQuestionUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, CreateQuestionCondition> {
  late final CorrectionRepository _correctionRepository;
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    super.onInit();

    _correctionRepository = Get.find<CorrectionRepository>();
    _questionRepository = Get.find<QuestionRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    CreateQuestionCondition condition,
  ) async {
    String content = condition.content;

    if (condition.isMadeByStt) {
      StateWrapper<String> correctContentWrapper =
          await _correctionRepository.correctSpeechText(
        CorrectSpeechTextCondition(
          content: content,
        ),
      );

      content = correctContentWrapper.data ?? content;
    }

    return await _questionRepository.createQuestion(
      CreateQuestionCondition(
        content: content,
        isMadeByStt: condition.isMadeByStt,
      ),
    );
  }
}
