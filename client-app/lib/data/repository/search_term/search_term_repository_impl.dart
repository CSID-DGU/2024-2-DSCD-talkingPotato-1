import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/data/provider/search_term/search_term_local_provider.dart';
import 'package:wooahan/domain/condition/search_term/upsert_article_search_term_list_condition.dart';
import 'package:wooahan/domain/condition/search_term/upsert_question_search_term_list_condition.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';

class SearchTermRepositoryImpl extends GetxService
    implements SearchTermRepository {
  late final SearchTermLocalProvider _searchTermLocalProvider;

  @override
  void onInit() {
    _searchTermLocalProvider = StorageFactory.searchTermLocalProvider;

    super.onInit();
  }

  @override
  StateWrapper<List<String>> readArticleSearchTermList() {
    return StateWrapper(
      success: true,
      data: _searchTermLocalProvider.getArticleSearchTermList(),
    );
  }

  @override
  StateWrapper<List<String>> readQuestionSearchTermList() {
    return StateWrapper(
      success: true,
      data: _searchTermLocalProvider.getQuestionSearchTermList(),
    );
  }

  @override
  Future<StateWrapper<void>> upsertArticleSearchTermList(
    UpsertArticleSearchTermListCondition condition,
  ) async {
    await _searchTermLocalProvider.putArticleSearchTermList(
      searchTerms: condition.searchTerms,
    );

    return StateWrapper(success: true);
  }

  @override
  Future<StateWrapper<void>> upsertQuestionSearchTermList(
    UpsertQuestionSearchTermListCondition condition,
  ) async {
    await _searchTermLocalProvider.putQuestionSearchTermList(
      searchTerms: condition.searchTerms,
    );

    return StateWrapper(success: true);
  }
}
