import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/question/question_remote_provider.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/condition/question/delete_question_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_brief_list_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_detail_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_summary_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/entity/question/question_detail_state.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';

class QuestionRepositoryImpl extends GetxService implements QuestionRepository {
  late final QuestionRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<QuestionRemoteProvider>();
  }

  @override
  Future<StateWrapper<List<QuestionBriefState>>> readQuestionBriefList(
    ReadQuestionBriefListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getQuestionList(
      page: condition.page.toString(),
      size: condition.size.toString(),
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<QuestionBriefState> questionBriefList = response.data!['questions']
        .map<QuestionBriefState>(
          (question) => QuestionBriefState.fromJson(question),
        )
        .toList();

    return StateWrapper(
      success: true,
      data: questionBriefList,
    );
  }

  @override
  Future<StateWrapper<List<QuestionSummaryState>>> readQuestionSummaryList(
    ReadQuestionSummaryListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getQuestionList(
      q: condition.searchTerm,
      page: condition.page.toString(),
      size: condition.size.toString(),
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<QuestionSummaryState> questionSummaryList = response.data!['questions']
        .map<QuestionSummaryState>(
          (question) => QuestionSummaryState.fromJson(question),
        )
        .toList();

    return StateWrapper(
      success: true,
      data: questionSummaryList,
    );
  }

  @override
  Future<StateWrapper<QuestionDetailState>> readQuestionDetail(
    ReadQuestionDetailCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getQuestion(
      questionId: condition.questionId,
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    QuestionDetailState questionDetail = QuestionDetailState.fromJson(
      response.data!,
    );

    return StateWrapper(
      success: true,
      data: questionDetail,
    );
  }

  @override
  Future<StateWrapper<List<QuestionBriefState>>>
      readQuestionBriefListByUser() async {
    ResponseWrapper response = await _remoteProvider.getMyQuestionList();

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
        data: [
          QuestionBriefState.initial(),
          QuestionBriefState.initial(),
          QuestionBriefState.initial(),
        ],
      );
    }

    List<QuestionBriefState> questionBriefList = [];

    questionBriefList.addAll(response.data!['questions']
        .map<QuestionBriefState>(
          (question) => QuestionBriefState.fromJson(question),
        )
        .toList());

    for (int i = questionBriefList.length; i < 3; i++) {
      questionBriefList.add(QuestionBriefState.initial());
    }

    return StateWrapper(
      success: true,
      data: questionBriefList,
    );
  }

  @override
  Future<StateWrapper<void>> createQuestion(
    CreateQuestionCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.postQuestion(
      content: condition.content,
      isMadeByStt: condition.isMadeByStt,
    );

    return StateWrapper.fromResponse(response);
  }

  @override
  Future<StateWrapper<void>> deleteQuestion(
    DeleteQuestionCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.deleteQuestion(
      questionId: condition.questionId,
    );

    return StateWrapper.fromResponse(response);
  }
}
