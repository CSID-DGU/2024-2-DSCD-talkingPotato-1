import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/read_question_summary_list_condition.dart';
import 'package:wooahan/domain/condition/search_term/upsert_question_search_term_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';
import 'package:wooahan/domain/usecase/question/read_question_summary_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/read_question_search_term_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/upsert_question_search_term_list_use_case.dart';

class QuestionSearchingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadQuestionSummaryListUseCase _readQuestionSummaryListUseCase;
  late final ReadQuestionSearchTermListUseCase
      _readQuestionSearchTermListUseCase;

  late final UpsertQuestionSearchTermListUseCase
      _upsertQuestionSearchTermListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxString _mode;

  late final RxBool _isInitLoading;
  late final RxBool _isLoading;

  late final RxString _searchTerm;
  late final RxList<String> _recentSearchTermList;
  late final RxList<QuestionSummaryState> _questionSummaryList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get mode => _mode.value;

  bool get isInitLoading => _isInitLoading.value;
  bool get isLoading => _isLoading.value;

  String get searchTerm => _searchTerm.value;
  List<String> get recentSearchTermList => _recentSearchTermList;
  List<QuestionSummaryState> get questionSummaryList => _questionSummaryList;

  get clearSearchTerm => null;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readQuestionSummaryListUseCase =
        Get.find<ReadQuestionSummaryListUseCase>();
    _readQuestionSearchTermListUseCase =
        Get.find<ReadQuestionSearchTermListUseCase>();

    _upsertQuestionSearchTermListUseCase =
        Get.find<UpsertQuestionSearchTermListUseCase>();

    _mode = 'searching'.obs;

    _isInitLoading = true.obs;
    _isLoading = false.obs;

    _searchTerm = ''.obs;
    _recentSearchTermList = <String>[].obs;
    _questionSummaryList = <QuestionSummaryState>[].obs;
  }

  @override
  void onReady() {
    super.onReady();

    fetchRecentSearchTermList();
  }

  void fetchRecentSearchTermList() {
    StateWrapper<List<String>> state =
        _readQuestionSearchTermListUseCase.execute();

    _recentSearchTermList.value = state.data!;
  }

  void updateSearchTerm(String value) {
    _mode.value = 'searching';

    _searchTerm.value = value;
  }

  void updateSearchTermBySearchTermItem(int index) {
    _mode.value = 'searching';

    _searchTerm.value = _recentSearchTermList[index];
  }

  void updateArticleSummaryList() async {
    _isLoading.value = true;

    _mode.value = 'searched';

    if (_recentSearchTermList.contains(_searchTerm.value)) {
      _recentSearchTermList.remove(_searchTerm.value);
    } else if (_recentSearchTermList.length >= 5) {
      _recentSearchTermList.removeLast();
    }

    _recentSearchTermList.insert(0, _searchTerm.value);

    await _upsertQuestionSearchTermListUseCase.execute(
      UpsertQuestionSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );

    StateWrapper<List<QuestionSummaryState>> state =
        await _readQuestionSummaryListUseCase.execute(
      ReadQuestionSummaryListCondition(
        searchTerm: _searchTerm.value,
        page: 0,
        size: 100,
      ),
    );

    if (!state.success) {
      return;
    }

    _questionSummaryList.value = state.data!;

    _isLoading.value = false;
  }

  void removeInRecentSearchTerm(int index) {
    _recentSearchTermList.removeAt(index);

    _upsertQuestionSearchTermListUseCase.execute(
      UpsertQuestionSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );
  }

  void removeAllInRecentSearchTermList() {
    _recentSearchTermList.clear();

    _upsertQuestionSearchTermListUseCase.execute(
      UpsertQuestionSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );
  }
}
