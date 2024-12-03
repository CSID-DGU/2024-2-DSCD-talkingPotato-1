import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_detail_condition.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_detail_state.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_detail_use_case.dart';
import 'package:wooahan/domain/usecase/comment/read_article_comment_list_use_case.dart';

class ArticleDetailViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int articleId;

  late final ReadArticleDetailUseCase _readArticleDetailUseCase;
  late final ReadArticleCommentListUseCase _readArticleCommentListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final Rx<ArticleDetailState> _articleDetail;
  late final RxList<CommentState> _articleCommentList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isInitLoading => _isInitLoading.value;
  ArticleDetailState get articleDetail => _articleDetail.value;
  List<CommentState> get articleCommentList => _articleCommentList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    articleId = int.parse(Get.parameters['id']!);

    _readArticleDetailUseCase = Get.find<ReadArticleDetailUseCase>();
    _readArticleCommentListUseCase = Get.find<ReadArticleCommentListUseCase>();

    _isInitLoading = true.obs;

    _articleDetail = ArticleDetailState.initial().obs;
    _articleCommentList = <CommentState>[].obs;
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
    StateWrapper<ArticleDetailState> state =
        await _readArticleDetailUseCase.execute(
      ReadArticleDetailCondition(
        articleId: articleId,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleDetail.value = state.data!;
  }

  Future<void> _fetchArticleCommentList() async {
    StateWrapper<List<CommentState>> state =
        await _readArticleCommentListUseCase.execute(
      ReadArticleCommentListCondition(
        articleId: articleId,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleCommentList.value = state.data!;
  }
}
