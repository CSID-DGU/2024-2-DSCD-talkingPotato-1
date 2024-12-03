import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_detail_condition.dart';
import 'package:wooahan/domain/entity/question/question_detail_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class ReadQuestionDetailUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<QuestionDetailState,
            ReadQuestionDetailCondition> {
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    _questionRepository = Get.find<QuestionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<QuestionDetailState>> execute(
    ReadQuestionDetailCondition condition,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(
      success: true,
      data: QuestionDetailState(
        id: 1,
        content: 'content',
        createdAt: 'createdAt',
        answerCnt: 1,
        creator: 'creator',
        creatorId: 'creatorId',
      ),
    );

    return await _questionRepository.readQuestionDetail(condition);
  }
}
