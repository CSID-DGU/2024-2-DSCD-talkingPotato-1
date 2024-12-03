import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/article/read_article_brief_list_use_case.dart';
import 'package:wooahan/domain/usecase/question/read_question_brief_list_use_case.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';

class BoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadArticleBriefListUseCase>(
      () => ReadArticleBriefListUseCase(),
    );
    Get.lazyPut<ReadQuestionBriefListUseCase>(
      () => ReadQuestionBriefListUseCase(),
    );

    Get.lazyPut<BoardViewModel>(() => BoardViewModel());
  }
}
