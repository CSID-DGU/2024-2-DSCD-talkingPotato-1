import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/article/default/article_view_model.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_view_model.dart';
import 'package:wooahan/presentation/view_model/article/searching/article_searching_view_model.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/view_model/home/home_view_model.dart';
import 'package:wooahan/presentation/view_model/medication/default/medication_view_model.dart';
import 'package:wooahan/presentation/view_model/question/default/question_view_model.dart';

class BaseMediator extends GetxService {
  Future<void> publishUpdateMedicationEvent() async {
    try {
      await Get.find<MedicationViewModel>().onRefresh();
    } catch (_) {}
  }

  Future<void> publishCreateArticleCommentEvent(int articleId) async {
    try {
      await Get.find<ArticleViewModel>()
          .consumeCreateArticleCommentEvent(articleId);
    } catch (_) {}
    try {
      await Get.find<ArticleSearchingViewModel>()
          .consumeCreateArticleCommentEvent(articleId);
    } catch (_) {}
    try {
      await Get.find<ArticleDetailViewModel>().onRefresh();
    } catch (_) {}
  }

  Future<void> publishDeleteArticleCommentEvent(int articleId) async {
    try {
      await Get.find<ArticleViewModel>()
          .consumeDeleteArticleCommentEvent(articleId);
    } catch (_) {}
    try {
      await Get.find<ArticleSearchingViewModel>()
          .consumeDeleteArticleCommentEvent(articleId);
    } catch (_) {}
  }

  Future<void> publishCreateQuestionEvent() async {
    try {
      await Get.find<HomeViewModel>().onRefresh();
    } catch (_) {}
    try {
      await Get.find<BoardViewModel>().onRefresh();
    } catch (_) {}
    try {
      await Get.find<QuestionViewModel>().onRefresh();
    } catch (_) {}
  }

  Future<void> publishDeleteQuestionEvent(int questionId) async {
    try {
      await Get.find<HomeViewModel>().onRefresh();
    } catch (_) {}
    try {
      await Get.find<BoardViewModel>().onRefresh();
    } catch (_) {}
    try {
      Get.find<QuestionViewModel>().consumeDeleteQuestionEvent(questionId);
    } catch (_) {}
  }
}
