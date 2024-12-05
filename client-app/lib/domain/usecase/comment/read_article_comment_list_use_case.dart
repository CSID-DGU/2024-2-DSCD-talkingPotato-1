import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class ReadArticleCommentListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<CommentState>,
            ReadArticleCommentListCondition> {
  late final UserRepository _userRepository;
  late final CommentRepository _commentRepository;

  @override
  void onInit() {
    _userRepository = Get.find<UserRepository>();
    _commentRepository = Get.find<CommentRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<CommentState>>> execute(
    ReadArticleCommentListCondition condition,
  ) async {
    StateWrapper<List<CommentState>> beforeState =
        await _commentRepository.readArticleCommentList(condition);
    StateWrapper<String> currentAccountId = _userRepository.readId();

    if (!beforeState.success) {
      return beforeState;
    }

    List<CommentState> commentList = beforeState.data!
        .map((e) => e.copyWith(
              currentAccountId: currentAccountId.data!,
            ))
        .toList();

    return StateWrapper(
      success: true,
      data: commentList,
    );
  }
}
