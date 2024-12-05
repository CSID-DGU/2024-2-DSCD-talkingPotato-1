import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/delete_article_comment_condition.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';

class DeleteArticleCommentUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, DeleteArticleCommentCondition> {
  late final CommentRepository _commentRepository;

  @override
  void onInit() {
    super.onInit();

    _commentRepository = Get.find<CommentRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    DeleteArticleCommentCondition condition,
  ) async {
    return await _commentRepository.deleteArticleComment(condition);
  }
}
