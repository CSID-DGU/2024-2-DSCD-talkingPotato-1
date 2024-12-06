import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/comment/create_article_comment_use_case.dart';
import 'package:wooahan/presentation/view_model/comment/adding/comment_adding_view_model.dart';

class CommentAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateArticleCommentUseCase>(
      () => CreateArticleCommentUseCase(),
    );

    Get.lazyPut<CommentAddingViewModel>(
      () => CommentAddingViewModel(),
    );
  }
}
