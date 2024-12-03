class ArticleBriefState {
  final int id;
  final String title;
  final String preview;
  final String createdAt;
  final String creator;

  ArticleBriefState({
    required this.id,
    required this.title,
    required this.preview,
    required this.createdAt,
    required this.creator,
  });

  ArticleBriefState copyWith({
    int? id,
    String? title,
    String? preview,
    String? createdAt,
    String? creator,
  }) {
    return ArticleBriefState(
      id: id ?? this.id,
      title: title ?? this.title,
      preview: preview ?? this.preview,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory ArticleBriefState.fromJson(Map<String, dynamic> map) {
    return ArticleBriefState(
      id: map['id'] as int,
      title: map['title'] as String,
      preview: map['preview'] as String,
      createdAt: map['created_at'] as String,
      creator: map['nickname'] as String,
    );
  }
}
