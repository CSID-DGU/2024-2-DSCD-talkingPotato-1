import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class CreateQuestionUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, CreateQuestionCondition> {
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    super.onInit();

    _questionRepository = Get.find<QuestionRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    CreateQuestionCondition condition,
  ) async {
    return await _questionRepository.createQuestion(condition);
  }
}
