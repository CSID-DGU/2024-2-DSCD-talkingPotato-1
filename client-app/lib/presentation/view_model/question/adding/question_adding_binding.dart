import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/question/create_question_use_case.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_view_model.dart';

class QuestionAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateQuestionUseCase>(
      () => CreateQuestionUseCase(),
    );

    Get.lazyPut<QuestionAddingViewModel>(
      () => QuestionAddingViewModel(),
    );
  }
}
