import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_no_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class ReadQuestionBriefListByUserUseCase extends BaseUseCase
    implements AsyncNoConditionUseCase<List<QuestionBriefState>> {
  late final QuestionRepository _questionRepository;

  @override
  void onInit() {
    _questionRepository = Get.find<QuestionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<QuestionBriefState>>> execute() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return await _questionRepository.readQuestionBriefListByUser();
  }
}
