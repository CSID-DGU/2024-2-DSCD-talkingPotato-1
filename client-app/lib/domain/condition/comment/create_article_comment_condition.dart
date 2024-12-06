class CreateArticleCommentCondition {
  final int articleId;
  final String content;
  final bool isMadeByStt;

  CreateArticleCommentCondition({
    required this.articleId,
    required this.content,
    required this.isMadeByStt,
  });
}
