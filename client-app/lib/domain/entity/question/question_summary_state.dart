class QuestionSummaryState {
  final int id;
  final String preview;
  final String answerStatus;
  final int answerCnt;
  final String createdAt;
  final String creator;

  QuestionSummaryState({
    required this.id,
    required this.preview,
    required this.answerStatus,
    required this.answerCnt,
    required this.createdAt,
    required this.creator,
  });

  QuestionSummaryState copyWith({
    int? id,
    String? preview,
    String? answerStatus,
    int? answerCnt,
    String? createdAt,
    String? creator,
  }) {
    return QuestionSummaryState(
      id: id ?? this.id,
      preview: preview ?? this.preview,
      answerStatus: answerStatus ?? this.answerStatus,
      answerCnt: answerCnt ?? this.answerCnt,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory QuestionSummaryState.fromJson(Map<String, dynamic> json) {
    return QuestionSummaryState(
      id: json['id'],
      preview: json['preview'],
      answerStatus: json['answer_status'],
      answerCnt: json['answer_count'],
      createdAt: json['created_at'],
      creator: json['nickname'],
    );
  }
}
