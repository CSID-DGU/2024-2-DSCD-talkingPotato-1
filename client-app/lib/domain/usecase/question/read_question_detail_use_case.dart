import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_detail_condition.dart';
import 'package:wooahan/domain/entity/question/question_detail_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class ReadQuestionDetailUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<QuestionDetailState,
            ReadQuestionDetailCondition> {
  late final UserRepository _userRepository;
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    _userRepository = Get.find<UserRepository>();
    _questionRepository = Get.find<QuestionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<QuestionDetailState>> execute(
    ReadQuestionDetailCondition condition,
  ) async {
    StateWrapper<QuestionDetailState> beforeState =
        await _questionRepository.readQuestionDetail(condition);

    if (!beforeState.success) {
      return beforeState;
    }

    StateWrapper<QuestionDetailState> afterState = StateWrapper(
      success: true,
      data: beforeState.data!.copyWith(
        myId: _userRepository.readId().data!,
      ),
    );

    return afterState;
  }
}
