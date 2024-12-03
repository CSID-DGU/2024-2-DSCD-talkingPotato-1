import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';

class ReadArticleCommentListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<CommentState>,
            ReadArticleCommentListCondition> {
  late final CommentRepository _commentRepository;

  @override
  void onInit() {
    _commentRepository = Get.find<CommentRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<CommentState>>> execute(
    ReadArticleCommentListCondition condition,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(success: true, data: [
      CommentState(
        id: 4,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
      CommentState(
        id: 3,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
      CommentState(
        id: 2,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
      CommentState(
        id: 1,
        content: '댓글 내용',
        createdAt: '2024-10-03',
        creator: '작성자',
        creatorId: '작성자 아이디',
      ),
    ]);

    return await _commentRepository.readArticleCommentList(condition);
  }
}
