import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_summary_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_summary_list_use_case.dart';

class ArticleViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadArticleSummaryListUseCase _readArticleSummaryListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final RxList<ArticleSummaryState> _articleSummaryList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isInitLoading.value;
  List<ArticleSummaryState> get articleSummaryList => _articleSummaryList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readArticleSummaryListUseCase = Get.find<ReadArticleSummaryListUseCase>();

    _isInitLoading = true.obs;
    _articleSummaryList = <ArticleSummaryState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    await Future.wait([
      _fetchArticleSummaryList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> onRefresh() async {
    _isInitLoading.value = true;

    await Future.wait([
      _fetchArticleSummaryList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> _fetchArticleSummaryList() async {
    StateWrapper<List<ArticleSummaryState>> state =
        await _readArticleSummaryListUseCase.execute(
      ReadArticleSummaryListCondition(
        searchTerm: '',
        page: 0,
        size: 100,
      ),
    );

    if (!state.success) {
      _isInitLoading.value = false;

      return;
    }

    _articleSummaryList.assignAll(state.data!);
  }

  Future<void> consumeCreateArticleCommentEvent(int articleId) async {
    _articleSummaryList.value = _articleSummaryList
        .map((articleSummary) => articleSummary.id == articleId
            ? articleSummary.copyWith(
                commentCnt: articleSummary.commentCnt + 1,
              )
            : articleSummary)
        .toList();
  }

  Future<void> consumeDeleteArticleCommentEvent(int articleId) async {
    _articleSummaryList.value = _articleSummaryList
        .map((articleSummary) => articleSummary.id == articleId
            ? articleSummary.copyWith(
                commentCnt: articleSummary.commentCnt - 1,
              )
            : articleSummary)
        .toList();
  }
}
