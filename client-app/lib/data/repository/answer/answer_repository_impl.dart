import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/answer/answer_remote_provider.dart';
import 'package:wooahan/domain/condition/answer/read_question_answer_list_condition.dart';
import 'package:wooahan/domain/entity/answer/answer_state.dart';
import 'package:wooahan/domain/repository/answer/answer_repository.dart';

class AnswerRepositoryImpl extends GetxService implements AnswerRepository {
  late final AnswerRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<AnswerRemoteProvider>();
  }

  @override
  Future<StateWrapper<List<AnswerState>>> readQuestionAnswerList(
    ReadQuestionAnswerListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getQuestionAnswerList(
      questionId: condition.questionId,
      page: '1',
      size: '10',
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<AnswerState> answerStateList = response.data!['answers']
        .map<AnswerState>((e) => AnswerState.fromJson(e))
        .toList();

    return StateWrapper(
      success: true,
      data: answerStateList,
    );
  }
}
