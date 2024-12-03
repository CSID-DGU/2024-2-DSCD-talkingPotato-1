import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/question/read_question_summary_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/read_question_search_term_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/upsert_question_search_term_list_use_case.dart';
import 'package:wooahan/presentation/view_model/question/searching/question_searching_view_model.dart';

class QuestionSearchingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadQuestionSummaryListUseCase>(
      () => ReadQuestionSummaryListUseCase(),
    );
    Get.lazyPut<ReadQuestionSearchTermListUseCase>(
      () => ReadQuestionSearchTermListUseCase(),
    );
    Get.lazyPut<UpsertQuestionSearchTermListUseCase>(
      () => UpsertQuestionSearchTermListUseCase(),
    );

    Get.lazyPut<QuestionSearchingViewModel>(
      () => QuestionSearchingViewModel(),
    );
  }
}
