class ArticleDetailState {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String creator;

  final List<String> tags;
  final int commentCnt;

  ArticleDetailState({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.creator,
    required this.tags,
    required this.commentCnt,
  });

  ArticleDetailState copyWith({
    int? id,
    String? title,
    String? content,
    String? createdAt,
    String? creator,
    List<String>? tags,
    int? commentCnt,
  }) {
    return ArticleDetailState(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      tags: tags ?? this.tags,
      commentCnt: commentCnt ?? this.commentCnt,
    );
  }

  factory ArticleDetailState.fromJson(Map<String, dynamic> map) {
    return ArticleDetailState(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['created_at'] as String,
      creator: map['nickname'] as String,
      tags: List<String>.from(map['tags'] as List),
      commentCnt: map['comment_cnt'] as int,
    );
  }

  factory ArticleDetailState.initial() {
    return ArticleDetailState(
      id: 0,
      title: '',
      content: '',
      createdAt: '',
      creator: '',
      tags: [],
      commentCnt: 0,
    );
  }
}
