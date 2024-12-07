import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/correction/correction_remote_provider.dart';

class CorrectionRemoteProviderImpl extends BaseConnect
    implements CorrectionRemoteProvider {
  @override
  Future<ResponseWrapper> postDocumentText({
    required String content,
  }) async {
    Response response = await post(
      '/llm/v1/corrections/documents',
      {
        'content': content,
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postSpeechText({
    required String content,
  }) async {
    Response response = await post(
      '/llm/v1/corrections/speeches',
      {
        'content': content,
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
