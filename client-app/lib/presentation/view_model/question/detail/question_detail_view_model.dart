import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/answer/read_question_answer_list_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_detail_condition.dart';
import 'package:wooahan/domain/entity/answer/answer_state.dart';
import 'package:wooahan/domain/entity/question/question_detail_state.dart';
import 'package:wooahan/domain/usecase/answer/read_question_answer_list_use_case.dart';
import 'package:wooahan/domain/usecase/question/read_question_detail_use_case.dart';

class QuestionDetailViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int questionId;

  late final ReadQuestionDetailUseCase _readQuestionDetailUseCase;
  late final ReadQuestionAnswerListUseCase _readQuestionAnswerListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final Rx<QuestionDetailState> _questionDetail;
  late final RxList<AnswerState> _answerList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isInitLoading => _isInitLoading.value;
  QuestionDetailState get questionDetail => _questionDetail.value;
  List<AnswerState> get answerList => _answerList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    questionId = int.parse(Get.parameters['id']!);

    _readQuestionDetailUseCase = Get.find<ReadQuestionDetailUseCase>();
    _readQuestionAnswerListUseCase = Get.find<ReadQuestionAnswerListUseCase>();

    _isInitLoading = true.obs;

    _questionDetail = QuestionDetailState.initial().obs;
    _answerList = <AnswerState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    _isInitLoading.value = true;

    await Future.wait([
      _fetchArticleDetail(),
      _fetchArticleCommentList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> _fetchArticleDetail() async {
    StateWrapper<QuestionDetailState> state =
        await _readQuestionDetailUseCase.execute(
      ReadQuestionDetailCondition(
        questionId: questionId,
      ),
    );

    if (!state.success) {
      return;
    }

    _questionDetail.value = state.data!;
  }

  Future<void> _fetchArticleCommentList() async {
    StateWrapper<List<AnswerState>> state =
        await _readQuestionAnswerListUseCase.execute(
      ReadQuestionAnswerListCondition(
        questionId: questionId,
      ),
    );

    if (!state.success) {
      return;
    }

    _answerList.addAll(state.data!);
  }
}
