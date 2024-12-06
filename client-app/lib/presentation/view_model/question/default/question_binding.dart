import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/question/read_question_summary_list_use_case.dart';
import 'package:wooahan/presentation/view_model/question/default/question_view_model.dart';

class QuestionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadQuestionSummaryListUseCase>(
      () => ReadQuestionSummaryListUseCase(),
    );

    Get.lazyPut<QuestionViewModel>(
      () => QuestionViewModel(),
    );
  }
}
