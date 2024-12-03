import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';

abstract class CommentRepository {
  Future<StateWrapper<List<CommentState>>> readArticleCommentList(
    ReadArticleCommentListCondition condition,
  );
}
