import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class AnswerRemoteProvider {
  Future<ResponseWrapper> getQuestionAnswerList({
    required int questionId,
    required String page,
    required String size,
  });
}
