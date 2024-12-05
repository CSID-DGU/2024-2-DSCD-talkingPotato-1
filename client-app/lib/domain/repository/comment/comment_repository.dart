import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/condition/comment/delete_article_comment_condition.dart';
import 'package:wooahan/domain/condition/comment/read_article_comment_list_condition.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';

abstract class CommentRepository {
  Future<StateWrapper<List<CommentState>>> readArticleCommentList(
    ReadArticleCommentListCondition condition,
  );

  Future<StateWrapper<void>> createArticleComment(
    CreateArticleCommentCondition condition,
  );

  Future<StateWrapper<void>> deleteArticleComment(
    DeleteArticleCommentCondition condition,
  );
}
