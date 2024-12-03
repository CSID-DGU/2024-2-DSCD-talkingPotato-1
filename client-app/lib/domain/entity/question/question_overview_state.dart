class QuestionOverviewState {
  final int id;
  final String question;
  final String answerType;
  final String createdAt;
  final String creator;

  QuestionOverviewState({
    required this.id,
    required this.question,
    required this.answerType,
    required this.createdAt,
    required this.creator,
  });

  QuestionOverviewState copyWith({
    int? id,
    String? question,
    String? answerType,
    String? createdAt,
    String? creator,
  }) {
    return QuestionOverviewState(
      id: id ?? this.id,
      question: question ?? this.question,
      answerType: answerType ?? this.answerType,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory QuestionOverviewState.fromJson(Map<String, dynamic> json) {
    return QuestionOverviewState(
      id: json["id"],
      question: json["question"],
      answerType: json["answer_type"],
      createdAt: json["created_at"],
      creator: json["creator"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer_type': answerType,
      'created_at': createdAt,
      'creator': creator,
    };
  }
}
