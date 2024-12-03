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
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(success: true, data: [
      AnswerState(
        id: 1,
        content: '댓글 내용',
        createdAt: '2024-10-03',
      ),
      AnswerState(
        id: 4,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
      AnswerState(
        id: 5,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
      AnswerState(
        id: 6,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
    ]);

    return await _answerRepository.readQuestionAnswerList(condition);
  }
}
