import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/answer/read_question_answer_list_use_case.dart';
import 'package:wooahan/domain/usecase/question/delete_question_use_case.dart';
import 'package:wooahan/domain/usecase/question/read_question_detail_use_case.dart';
import 'package:wooahan/presentation/view_model/question/detail/question_detail_view_model.dart';

class QuestionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadQuestionDetailUseCase>(
      () => ReadQuestionDetailUseCase(),
    );
    Get.lazyPut<ReadQuestionAnswerListUseCase>(
      () => ReadQuestionAnswerListUseCase(),
    );
    Get.lazyPut<DeleteQuestionUseCase>(
      () => DeleteQuestionUseCase(),
    );

    Get.lazyPut<QuestionDetailViewModel>(() => QuestionDetailViewModel());
  }
}
