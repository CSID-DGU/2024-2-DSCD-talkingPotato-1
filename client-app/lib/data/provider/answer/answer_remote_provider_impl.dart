import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/answer/answer_remote_provider.dart';

class AnswerRemoteProviderImpl extends BaseConnect
    implements AnswerRemoteProvider {
  @override
  Future<ResponseWrapper> getQuestionAnswerList({
    required int questionId,
    required String page,
    required String size,
  }) async {
    Response response = await get(
      '/questions/$questionId/answers',
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
