import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';

class CreateArticleCommentUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, CreateArticleCommentCondition> {
  late final CommentRepository _commentRepository;

  @override
  void onInit() {
    super.onInit();

    _commentRepository = Get.find<CommentRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    CreateArticleCommentCondition condition,
  ) async {
    return await _commentRepository.createArticleComment(condition);
  }
}
