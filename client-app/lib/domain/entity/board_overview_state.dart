class BoardOverviewState {
  final int id;
  final String title;
  final String content;
  final String createdAt;
  final String creator;

  BoardOverviewState({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.creator,
  });

  BoardOverviewState copyWith({
    int? id,
    String? title,
    String? content,
    String? createdAt,
    String? creator,
  }) {
    return BoardOverviewState(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory BoardOverviewState.fromJson(Map<String, dynamic> map) {
    return BoardOverviewState(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      createdAt: map['createdAt'] as String,
      creator: map['creator'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt,
      'creator': creator,
    };
  }
}
