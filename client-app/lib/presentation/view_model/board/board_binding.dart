import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';

class BoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardViewModel>(() => BoardViewModel());
  }
}
