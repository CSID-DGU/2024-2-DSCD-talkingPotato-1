import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/answer/read_question_answer_list_condition.dart';
import 'package:wooahan/domain/entity/answer/answer_state.dart';
import 'package:wooahan/domain/repository/answer/answer_repository.dart';

class ReadQuestionAnswerListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<AnswerState>,
            ReadQuestionAnswerListCondition> {
  late final AnswerRepository _answerRepository;

  @override
  void onInit() {
    _answerRepository = Get.find<AnswerRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<AnswerState>>> execute(
    ReadQuestionAnswerListCondition condition,
  ) async {
    return await _answerRepository.readQuestionAnswerList(condition);
  }
}
