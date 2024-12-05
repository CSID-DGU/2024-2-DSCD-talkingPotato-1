import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_summary_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';
import 'package:wooahan/domain/usecase/question/read_question_summary_list_use_case.dart';

class QuestionViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadQuestionSummaryListUseCase _readQuestionSummaryListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final RxBool _isMoreLoading;
  late final RxList<QuestionSummaryState> _questionSummaryList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isInitLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;
  List<QuestionSummaryState> get questionSummaryList => _questionSummaryList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readQuestionSummaryListUseCase =
        Get.find<ReadQuestionSummaryListUseCase>();

    _isInitLoading = true.obs;
    _isMoreLoading = false.obs;
    _questionSummaryList = <QuestionSummaryState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    _isInitLoading.value = true;

    await Future.wait([
      _fetchQuestionSummaryList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> onRefresh() async {
    _isInitLoading.value = true;

    await Future.wait([
      _fetchQuestionSummaryList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> _fetchQuestionSummaryList() async {
    StateWrapper<List<QuestionSummaryState>> state =
        await _readQuestionSummaryListUseCase.execute(
      ReadQuestionSummaryListCondition(
        searchTerm: '',
        page: 0,
        size: 100,
      ),
    );

    if (!state.success) {
      _isInitLoading.value = false;

      return;
    }

    _questionSummaryList.assignAll(state.data!);
  }

  void consumeDeleteQuestionEvent(int questionId) {
    _questionSummaryList.removeWhere((element) => element.id == questionId);
  }
}
