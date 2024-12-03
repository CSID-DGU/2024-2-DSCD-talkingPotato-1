import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/search_term/upsert_article_search_term_list_condition.dart';
import 'package:wooahan/domain/condition/search_term/upsert_question_search_term_list_condition.dart';

abstract class SearchTermRepository {
  StateWrapper<List<String>> readArticleSearchTermList();
  StateWrapper<List<String>> readQuestionSearchTermList();

  Future<StateWrapper<void>> upsertArticleSearchTermList(
    UpsertArticleSearchTermListCondition condition,
  );
  Future<StateWrapper<void>> upsertQuestionSearchTermList(
    UpsertQuestionSearchTermListCondition condition,
  );
}
