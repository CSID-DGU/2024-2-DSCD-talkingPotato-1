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
  late final RxBool _isMoreLoading;
  late final RxList<ArticleSummaryState> _articleSummaryList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isInitLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;
  List<ArticleSummaryState> get articleSummaryList => _articleSummaryList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readArticleSummaryListUseCase = Get.find<ReadArticleSummaryListUseCase>();

    _isInitLoading = true.obs;
    _isMoreLoading = false.obs;
    _articleSummaryList = <ArticleSummaryState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    await _fetchArticleSummaryList();
  }

  Future<void> _fetchArticleSummaryList() async {
    _isInitLoading.value = true;

    StateWrapper<List<ArticleSummaryState>> state =
        await _readArticleSummaryListUseCase.execute(
      ReadArticleSummaryListCondition(
        searchTerm: '',
        page: 1,
        size: 10,
      ),
    );

    if (!state.success) {
      _isInitLoading.value = false;

      return;
    }

    _articleSummaryList.addAll(state.data!);

    _isInitLoading.value = false;
  }
}
