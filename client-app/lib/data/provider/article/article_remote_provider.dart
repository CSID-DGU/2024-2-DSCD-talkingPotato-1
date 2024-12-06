import '../../../core/wrapper/response_wrapper.dart';

abstract class ArticleRemoteProvider {
  Future<ResponseWrapper> getArticleList({
    String q = '',
    required String page,
    required String size,
  });

  Future<ResponseWrapper> getArticle({
    required int articleId,
  });
}
