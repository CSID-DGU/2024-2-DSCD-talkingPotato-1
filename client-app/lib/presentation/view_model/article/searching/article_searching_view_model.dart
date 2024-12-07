import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_summary_list_condition.dart';
import 'package:wooahan/domain/condition/search_term/upsert_article_search_term_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_summary_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/read_article_search_term_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/upsert_article_search_term_list_use_case.dart';

class ArticleSearchingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadArticleSummaryListUseCase _readArticleSummaryListUseCase;
  late final ReadArticleSearchTermListUseCase _readArticleSearchTermListUseCase;

  late final UpsertArticleSearchTermListUseCase
      _upsertArticleSearchTermListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxString _mode;

  late final RxBool _isInitLoading;
  late final RxBool _isLoading;

  late final RxString _searchTerm;
  late final RxList<String> _recentSearchTermList;
  late final RxList<ArticleSummaryState> _articleSummaryList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get mode => _mode.value;

  bool get isInitLoading => _isInitLoading.value;
  bool get isLoading => _isLoading.value;

  String get searchTerm => _searchTerm.value;
  List<String> get recentSearchTermList => _recentSearchTermList;
  List<ArticleSummaryState> get articleSummaryList => _articleSummaryList;

  get clearSearchTerm => null;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readArticleSummaryListUseCase = Get.find<ReadArticleSummaryListUseCase>();
    _readArticleSearchTermListUseCase =
        Get.find<ReadArticleSearchTermListUseCase>();

    _upsertArticleSearchTermListUseCase =
        Get.find<UpsertArticleSearchTermListUseCase>();

    _mode = 'searching'.obs;

    _isInitLoading = true.obs;
    _isLoading = false.obs;

    _searchTerm = ''.obs;
    _recentSearchTermList = <String>[].obs;
    _articleSummaryList = <ArticleSummaryState>[].obs;
  }

  @override
  void onReady() {
    super.onReady();

    fetchRecentSearchTermList();
  }

  void fetchRecentSearchTermList() {
    StateWrapper<List<String>> state =
        _readArticleSearchTermListUseCase.execute();

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

    await _upsertArticleSearchTermListUseCase.execute(
      UpsertArticleSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );

    StateWrapper<List<ArticleSummaryState>> state =
        await _readArticleSummaryListUseCase.execute(
      ReadArticleSummaryListCondition(
        searchTerm: _searchTerm.value,
        page: 0,
        size: 100,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleSummaryList.value = state.data!;

    _isLoading.value = false;
  }

  void clearRecentSearchTermList() {
    _recentSearchTermList.clear();

    _upsertArticleSearchTermListUseCase.execute(
      UpsertArticleSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );
  }

  void removeRecentSearchTerm(int index) {
    _recentSearchTermList.removeAt(index);

    _upsertArticleSearchTermListUseCase.execute(
      UpsertArticleSearchTermListCondition(
        searchTerms: _recentSearchTermList,
      ),
    );
  }

  Future<void> consumeCreateArticleCommentEvent(int articleId) async {
    if (_mode.value != 'searched') {
      return;
    }

    _articleSummaryList.value = _articleSummaryList
        .map((articleSummary) => articleSummary.id == articleId
            ? articleSummary.copyWith(
                commentCnt: articleSummary.commentCnt + 1,
              )
            : articleSummary)
        .toList();
  }

  Future<void> consumeDeleteArticleCommentEvent(int articleId) async {
    if (_mode.value != 'searched') {
      return;
    }

    _articleSummaryList.value = _articleSummaryList
        .map((articleSummary) => articleSummary.id == articleId
            ? articleSummary.copyWith(
                commentCnt: articleSummary.commentCnt - 1,
              )
            : articleSummary)
        .toList();
  }
}
