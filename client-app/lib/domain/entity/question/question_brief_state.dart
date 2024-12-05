class QuestionBriefState {
  final int id;
  final String preview;
  final String answerStatus;
  final String createdAt;
  final String creator;

  QuestionBriefState({
    required this.id,
    required this.preview,
    required this.answerStatus,
    required this.createdAt,
    required this.creator,
  });

  QuestionBriefState copyWith({
    int? id,
    String? preview,
    String? answerStatus,
    String? createdAt,
    String? creator,
  }) {
    return QuestionBriefState(
      id: id ?? this.id,
      preview: preview ?? this.preview,
      answerStatus: answerStatus ?? this.answerStatus,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory QuestionBriefState.fromJson(Map<String, dynamic> json) {
    return QuestionBriefState(
      id: json['id'],
      preview: json['preview'],
      answerStatus: json['answer_status'],
      createdAt: json['created_at'],
      creator: json['nickname'],
    );
  }

  factory QuestionBriefState.initial() {
    return QuestionBriefState(
      id: 0,
      preview: '',
      answerStatus: '',
      createdAt: '',
      creator: '',
    );
  }
}
