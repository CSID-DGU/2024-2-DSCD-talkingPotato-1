class AnswerState {
  final int id;
  final String content;
  final String createdAt;
  final String? creator;
  final String? creatorId;

  AnswerState({
    required this.id,
    required this.content,
    required this.createdAt,
    this.creator,
    this.creatorId,
  });

  factory AnswerState.fromJson(Map<String, dynamic> json) {
    return AnswerState(
      id: json['id'],
      content: json['content'],
      createdAt: json['created_at'],
      creator: json['nickname'],
      creatorId: json['creator_id'],
    );
  }
}
