import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class CorrectionRemoteProvider {
  Future<ResponseWrapper> postDocumentText({
    required String content,
  });

  Future<ResponseWrapper> postSpeechText({
    required String content,
  });
}
