class CommentState {
  final int id;
  final String content;
  final String createdAt;

  final String creator;
  final String creatorId;

  final String? currentAccountId;

  bool get isMine =>
      currentAccountId == null ? false : currentAccountId == creatorId;

  CommentState({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.creator,
    required this.creatorId,
    this.currentAccountId,
  });

  CommentState copyWith({
    int? id,
    String? content,
    String? createdAt,
    String? creator,
    String? creatorId,
    String? currentAccountId,
  }) {
    return CommentState(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
      currentAccountId: currentAccountId ?? this.currentAccountId,
    );
  }

  factory CommentState.fromJson(Map<String, dynamic> json) {
    return CommentState(
      id: json['id'] as int,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
      creator: json['nickname'] as String,
      creatorId: json['creator_id'] as String,
    );
  }
}
