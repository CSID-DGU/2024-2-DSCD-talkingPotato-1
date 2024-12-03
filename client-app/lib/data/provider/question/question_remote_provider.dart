import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class QuestionRemoteProvider {
  Future<ResponseWrapper> getQuestionList({
    String q = '',
    required String page,
    required String size,
  });

  Future<ResponseWrapper> getQuestion({
    required int questionId,
  });
}
