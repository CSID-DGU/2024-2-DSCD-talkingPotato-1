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
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(
      success: true,
      data: [
        QuestionSummaryState(
          id: 1,
          preview:
              '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
          createdAt: '2024-10-31 10:21:22',
          creator: '홍길동',
          answerStatus: 'NONE',
          answerCnt: 0,
        ),
        QuestionSummaryState(
          id: 2,
          preview:
              '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
          createdAt: '2024-10-30 10:21:22',
          creator: '길동홍',
          answerStatus: 'AI',
          answerCnt: 7,
        ),
        QuestionSummaryState(
          id: 3,
          preview:
              '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
          createdAt: '2024-10-30 10:21:22',
          creator: '동홍길',
          answerStatus: 'EXPERT',
          answerCnt: 10,
        ),
      ],
    );

    return await _questionRepository.readQuestionSummaryList(condition);
  }
}
