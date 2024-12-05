import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_brief_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class ReadQuestionBriefListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<QuestionBriefState>,
            ReadQuestionBriefListCondition> {
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    _questionRepository = Get.find<QuestionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<QuestionBriefState>>> execute(
    ReadQuestionBriefListCondition condition,
  ) async {
    return await _questionRepository.readQuestionBriefList(condition);
  }
}
