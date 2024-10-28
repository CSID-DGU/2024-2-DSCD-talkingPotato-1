class ScheduleChunkState {
  final String timeline;
  final int takenAmount;
  final int totalAmount;

  final bool isNow;

  double get percent => totalAmount == 0 ? 0 : takenAmount / totalAmount;

  ScheduleChunkState({
    required this.timeline,
    required this.takenAmount,
    required this.totalAmount,
    required this.isNow,
  });

  ScheduleChunkState copyWith({
    String? timeline,
    int? takenAmount,
    int? totalAmount,
    bool? isNow,
  }) {
    return ScheduleChunkState(
      timeline: timeline ?? this.timeline,
      takenAmount: takenAmount ?? this.takenAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      isNow: isNow ?? this.isNow,
    );
  }

  factory ScheduleChunkState.fromJson(Map<String, dynamic> json) {
    return ScheduleChunkState(
      timeline: json["timeline"],
      takenAmount: json["taken_amount"],
      totalAmount: json["total_amount"],
      isNow: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeline': timeline,
      'taken_amount': takenAmount,
      'total_amount': totalAmount,
      'is_now': isNow,
    };
  }
}
