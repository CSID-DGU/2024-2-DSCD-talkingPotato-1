import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/article/article_remote_provider.dart';

class ArticleRemoteProviderImpl extends BaseConnect
    implements ArticleRemoteProvider {
  @override
  Future<ResponseWrapper> getArticleList({
    String q = '',
    required String page,
    required String size,
  }) async {
    Map<String, dynamic> query = {
      'page': page,
      'size': size,
    };

    if (q.isNotEmpty) {
      query['q'] = q;
    }

    Response response = await get(
      '/api/v1/articles',
      query: query,
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getArticle({
    required int articleId,
  }) async {
    Response response = await get(
      '/api/v1/articles/$articleId',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
