import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/view_model/question/default/question_view_model.dart';

class BaseMediator extends GetxService {
  void propagateArticle() {}

  Future<void> publishCreateQuestionEvent() async {
    try {
      await Get.find<BoardViewModel>().onRefresh();
    } catch (_) {}
    try {
      await Get.find<QuestionViewModel>().onRefresh();
    } catch (_) {}
  }

  Future<void> publishDeleteQuestionEvent(int questionId) async {
    try {
      await Get.find<BoardViewModel>().onRefresh();
    } catch (_) {}
    try {
      Get.find<QuestionViewModel>().consumeDeleteQuestionEvent(questionId);
    } catch (_) {}
  }
}
