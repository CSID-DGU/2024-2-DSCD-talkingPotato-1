class ScheduleSummaryState {
  final String timeline;
  final int takenAmount;
  final int totalAmount;

  final bool isNow;

  double get percent => totalAmount == 0 ? 0 : takenAmount / totalAmount;

  ScheduleSummaryState({
    required this.timeline,
    required this.takenAmount,
    required this.totalAmount,
    required this.isNow,
  });

  ScheduleSummaryState copyWith({
    String? timeline,
    int? takenAmount,
    int? totalAmount,
    bool? isNow,
  }) {
    return ScheduleSummaryState(
      timeline: timeline ?? this.timeline,
      takenAmount: takenAmount ?? this.takenAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      isNow: isNow ?? this.isNow,
    );
  }

  factory ScheduleSummaryState.fromJson(
    String timeline,
    Map<String, dynamic> json,
  ) {
    return ScheduleSummaryState(
      timeline: timeline,
      takenAmount: json["takenDrugCount"],
      totalAmount: json["totalDrugCount"],
      isNow: false,
    );
  }

  @override
  String toString() {
    return 'ScheduleSummaryState(timeline: $timeline, takenAmount: $takenAmount, totalAmount: $totalAmount, isNow: $isNow)';
  }
}
