abstract class SearchTermLocalProvider {
  List<String> getArticleSearchTermList();
  List<String> getQuestionSearchTermList();

  Future<void> putArticleSearchTermList({
    required List<String> searchTerms,
  });
  Future<void> putQuestionSearchTermList({
    required List<String> searchTerms,
  });
}

extension SearchTermLocalProviderrExt on SearchTermLocalProvider {
  static const String articleSearchTermList = "articleSearchTerms";
  static const String questionSearchTermList = "questionSearchTerms";
}
