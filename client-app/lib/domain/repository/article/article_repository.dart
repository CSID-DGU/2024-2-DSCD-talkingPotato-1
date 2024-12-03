import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_brief_list_condition.dart';
import 'package:wooahan/domain/condition/article/read_article_detail_condition.dart';
import 'package:wooahan/domain/condition/article/read_article_summary_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_brief_state.dart';
import 'package:wooahan/domain/entity/article/article_detail_state.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';

abstract class ArticleRepository {
  Future<StateWrapper<List<ArticleBriefState>>> readArticleBriefList(
    ReadArticleBriefListCondition condition,
  );

  Future<StateWrapper<List<ArticleSummaryState>>> readArticleSummaryList(
    ReadArticleSummaryListCondition condition,
  );

  Future<StateWrapper<ArticleDetailState>> readArticleDetail(
    ReadArticleDetailCondition condition,
  );
}
