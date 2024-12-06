class ArticleSummaryState {
  final int id;
  final String title;
  final String preview;
  final String createdAt;
  final String creator;
  final String? thumbnailUrl;

  final List<String> tags;
  final int commentCnt;

  ArticleSummaryState({
    required this.id,
    required this.title,
    required this.preview,
    required this.createdAt,
    required this.creator,
    required this.tags,
    required this.commentCnt,
    this.thumbnailUrl,
  });

  ArticleSummaryState copyWith({
    int? id,
    String? title,
    String? preview,
    String? createdAt,
    String? creator,
    List<String>? tags,
    int? commentCnt,
    String? thumbnailUrl,
  }) {
    return ArticleSummaryState(
      id: id ?? this.id,
      title: title ?? this.title,
      preview: preview ?? this.preview,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      tags: tags ?? this.tags,
      commentCnt: commentCnt ?? this.commentCnt,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }

  factory ArticleSummaryState.fromJson(Map<String, dynamic> map) {
    return ArticleSummaryState(
      id: map['id'] as int,
      title: map['title'] as String,
      preview: map['preview'] as String,
      createdAt: map['created_at'] as String,
      creator: map['nickname'] as String,
      tags: List<String>.from(map['tags'] as List),
      commentCnt: map['comment_cnt'] as int,
      thumbnailUrl: map['thumbnail_url'] as String?,
    );
  }
}
