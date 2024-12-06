import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider.dart';

class CommentRemoteProviderImpl extends BaseConnect
    implements CommentRemoteProvider {
  @override
  Future<ResponseWrapper> getArticleCommentList({
    required int articleId,
    required int page,
    required int size,
  }) async {
    Response response = await get(
      '/api/v1/articles/$articleId/comments',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postArticleComment({
    required int articleId,
    required String content,
    required bool isMadeByStt,
  }) async {
    Response response = await post(
      '/api/v1/articles/$articleId/comments',
      headers: BaseConnect.useBearerToken,
      {
        'content': content,
        'is_made_by_stt': isMadeByStt,
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> deleteArticleComment({
    required int commentId,
  }) async {
    Response response = await delete(
      '/api/v1/comments/$commentId',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
