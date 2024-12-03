class QuestionDetailState {
  final int id;
  final String content;
  final String createdAt;

  final int answerCnt;

  final String creator;
  final String creatorId;

  QuestionDetailState({
    required this.id,
    required this.content,
    required this.answerCnt,
    required this.createdAt,
    required this.creator,
    required this.creatorId,
  });

  QuestionDetailState copyWith({
    int? id,
    String? content,
    String? answerStatus,
    int? answerCnt,
    String? createdAt,
    String? creator,
    String? creatorId,
  }) {
    return QuestionDetailState(
      id: id ?? this.id,
      content: content ?? this.content,
      answerCnt: answerCnt ?? this.answerCnt,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      creatorId: creatorId ?? this.creatorId,
    );
  }

  factory QuestionDetailState.fromJson(Map<String, dynamic> json) {
    return QuestionDetailState(
      id: json['id'],
      content: json['content'],
      answerCnt: json['answer_cnt'],
      createdAt: json['created_at'],
      creator: json['nickname'],
      creatorId: json['creator_id'],
    );
  }

  factory QuestionDetailState.initial() {
    return QuestionDetailState(
      id: 0,
      content: '',
      answerCnt: 0,
      createdAt: '',
      creator: '',
      creatorId: '',
    );
  }
}
