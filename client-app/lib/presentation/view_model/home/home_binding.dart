import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/question/read_question_brief_list_by_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_nickname_in_user_use_case.dart';
import 'package:wooahan/presentation/view_model/home/home_view_model.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadNicknameInUserUseCase>(
      () => ReadNicknameInUserUseCase(),
    );
    Get.lazyPut<ReadQuestionBriefListByUserUseCase>(
      () => ReadQuestionBriefListByUserUseCase(),
    );

    Get.lazyPut<HomeViewModel>(
      () => HomeViewModel(),
    );
  }
}
