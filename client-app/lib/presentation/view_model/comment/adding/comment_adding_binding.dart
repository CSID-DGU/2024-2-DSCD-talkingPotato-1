import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/comment/adding/comment_adding_view_model.dart';

class CommentAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentAddingViewModel>(() => CommentAddingViewModel());
  }
}
