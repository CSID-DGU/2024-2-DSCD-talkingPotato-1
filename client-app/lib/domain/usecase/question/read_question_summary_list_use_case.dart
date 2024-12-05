import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_summary_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class ReadQuestionSummaryListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<QuestionSummaryState>,
            ReadQuestionSummaryListCondition> {
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    _questionRepository = Get.find<QuestionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<QuestionSummaryState>>> execute(
    ReadQuestionSummaryListCondition condition,
  ) async {
    return await _questionRepository.readQuestionSummaryList(condition);
  }
}
