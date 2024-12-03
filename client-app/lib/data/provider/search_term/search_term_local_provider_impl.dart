import 'package:get_storage/get_storage.dart';

import 'search_term_local_provider.dart';

class SearchTermLocalProviderImpl implements SearchTermLocalProvider {
  SearchTermLocalProviderImpl({
    required GetStorage storage,
  }) : _storage = storage;

  final GetStorage _storage;

  @override
  List<String> getArticleSearchTermList() {
    List<dynamic>? searchTerms =
        _storage.read(SearchTermLocalProviderrExt.articleSearchTermList) ?? [];

    return searchTerms.map((e) => e.toString()).toList();
  }

  @override
  List<String> getQuestionSearchTermList() {
    List<dynamic>? searchTerms =
        _storage.read(SearchTermLocalProviderrExt.questionSearchTermList) ?? [];

    return searchTerms.map((e) => e.toString()).toList();
  }

  @override
  Future<void> putArticleSearchTermList({
    required List<String> searchTerms,
  }) async {
    return await _storage.write(
      SearchTermLocalProviderrExt.articleSearchTermList,
      searchTerms,
    );
  }

  @override
  Future<void> putQuestionSearchTermList({
    required List<String> searchTerms,
  }) async {
    return await _storage.write(
      SearchTermLocalProviderrExt.questionSearchTermList,
      searchTerms,
    );
  }
}
