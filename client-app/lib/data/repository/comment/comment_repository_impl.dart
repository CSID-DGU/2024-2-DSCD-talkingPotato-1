import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/condition/comment/delete_article_comment_condition.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';

class CommentRepositoryImpl extends GetxService implements CommentRepository {
  late final CommentRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<CommentRemoteProvider>();
  }

  @override
  Future<StateWrapper<List<CommentState>>> readArticleCommentList(
    ReadArticleCommentListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getArticleCommentList(
      articleId: condition.articleId,
      page: 0,
      size: 0,
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<CommentState> commentList = response.data!['comments']
        .map<CommentState>((e) => CommentState.fromJson(e))
        .toList();

    return StateWrapper(
      success: true,
      data: commentList,
    );
  }

  @override
  Future<StateWrapper<void>> createArticleComment(
      CreateArticleCommentCondition condition) async {
    ResponseWrapper response = await _remoteProvider.postArticleComment(
      articleId: condition.articleId,
      content: condition.content,
      isMadeByStt: condition.isMadeByStt,
    );

    return StateWrapper.fromResponse(response);
  }

  @override
  Future<StateWrapper<void>> deleteArticleComment(
    DeleteArticleCommentCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.deleteArticleComment(
      commentId: condition.commentId,
    );

    return StateWrapper.fromResponse(response);
  }
}
