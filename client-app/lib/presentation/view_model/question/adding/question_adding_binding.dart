import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_view_model.dart';

class QuestionAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionAddingViewModel>(() => QuestionAddingViewModel());
  }
}
