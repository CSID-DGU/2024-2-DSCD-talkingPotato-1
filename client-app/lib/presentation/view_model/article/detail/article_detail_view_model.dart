import 'package:get/get.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_detail_condition.dart';
import 'package:wooahan/domain/condition/comment/delete_article_comment_condition.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_detail_state.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_detail_use_case.dart';
import 'package:wooahan/domain/usecase/comment/delete_article_comment_use_case.dart';
import 'package:wooahan/domain/usecase/comment/read_article_comment_list_use_case.dart';

class ArticleDetailViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int _articleId;

  late final ReadArticleDetailUseCase _readArticleDetailUseCase;
  late final ReadArticleCommentListUseCase _readArticleCommentListUseCase;

  late final DeleteArticleCommentUseCase _deleteArticleCommentUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;
  late final Rx<ArticleDetailState> _articleDetail;
  late final RxList<CommentState> _articleCommentList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isLoading.value;
  ArticleDetailState get articleDetail => _articleDetail.value;
  List<CommentState> get articleCommentList => _articleCommentList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _articleId = int.parse(Get.parameters['id']!);

    _readArticleDetailUseCase = Get.find<ReadArticleDetailUseCase>();
    _readArticleCommentListUseCase = Get.find<ReadArticleCommentListUseCase>();
    _deleteArticleCommentUseCase = Get.find<DeleteArticleCommentUseCase>();

    _isLoading = true.obs;

    _articleDetail = ArticleDetailState.initial().obs;
    _articleCommentList = <CommentState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.wait([
      _fetchArticleDetail(),
      _fetchArticleCommentList(),
    ]);

    _isLoading.value = false;
  }

  Future<void> onRefresh() async {
    await Future.wait([
      _fetchArticleDetail(),
      _fetchArticleCommentList(),
    ]);
  }

  Future<void> _fetchArticleDetail() async {
    StateWrapper<ArticleDetailState> state =
        await _readArticleDetailUseCase.execute(
      ReadArticleDetailCondition(
        articleId: _articleId,
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
        articleId: _articleId,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleCommentList.value = state.data!;
  }

  Future<void> deleteArticleComment(int commentIndex) async {
    CommentState comment = _articleCommentList[commentIndex];

    StateWrapper<void> state = await _deleteArticleCommentUseCase.execute(
      DeleteArticleCommentCondition(
        commentId: comment.id,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleCommentList.removeAt(commentIndex);
    _articleDetail.value = _articleDetail.value.copyWith(
      commentCnt: _articleDetail.value.commentCnt - 1,
    );

    await Get.find<BaseMediator>().publishDeleteArticleCommentEvent(_articleId);
  }
}
