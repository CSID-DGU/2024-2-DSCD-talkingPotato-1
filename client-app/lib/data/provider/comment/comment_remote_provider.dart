import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class CommentRemoteProvider {
  Future<ResponseWrapper> getArticleCommentList({
    required int articleId,
    required int page,
    required int size,
  });

  Future<ResponseWrapper> postArticleComment({
    required int articleId,
    required String content,
    required bool isMadeByStt,
  });

  Future<ResponseWrapper> deleteArticleComment({
    required int commentId,
  });
}
