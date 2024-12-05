import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/question/question_remote_provider.dart';

class QuestionRemoteProviderImpl extends BaseConnect
    implements QuestionRemoteProvider {
  @override
  Future<ResponseWrapper> getQuestionList({
    String q = '',
    required String page,
    required String size,
  }) async {
    Map<String, String> query = {
      'page': page,
      'size': size,
    };

    if (q.isNotEmpty) {
      query['q'] = q;
    }

    Response response = await get(
      '/api/v1/questions',
      query: query,
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getMyQuestionList() async {
    Response response = await get(
      '/api/v1/users/questions',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getQuestion({
    required int questionId,
  }) async {
    Response response = await get(
      '/api/v1/questions/$questionId',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postQuestion({
    required String content,
    required bool isMadeByStt,
  }) async {
    Response response = await post(
      '/api/v1/questions',
      {
        'content': content,
        'is_made_by_stt': isMadeByStt,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> deleteQuestion({
    required int questionId,
  }) async {
    await delete(
      '/api/v1/questions/$questionId',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.noContent();
  }
}
