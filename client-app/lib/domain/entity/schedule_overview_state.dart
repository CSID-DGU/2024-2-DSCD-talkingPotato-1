class ScheduleOverviewState {
  final int id;
  final String takenAt;
  final bool isTaken;

  final int? drugId;
  final String drugType;
  final String drugName;
  final String? drugClassificationOrManufacturer;
  final String? drugImageUrl;

  ScheduleOverviewState({
    required this.id,
    required this.takenAt,
    required this.isTaken,
    this.drugId,
    required this.drugType,
    required this.drugName,
    this.drugClassificationOrManufacturer,
    this.drugImageUrl,
  });

  ScheduleOverviewState copyWith({
    int? id,
    String? takenAt,
    bool? isTaken,
    int? drugId,
    String? drugType,
    String? drugName,
    String? drugClassificationOrManufacturer,
    String? drugImageUrl,
  }) {
    return ScheduleOverviewState(
      id: id ?? this.id,
      takenAt: takenAt ?? this.takenAt,
      isTaken: isTaken ?? this.isTaken,
      drugId: drugId ?? this.drugId,
      drugType: drugType ?? this.drugType,
      drugName: drugName ?? this.drugName,
      drugClassificationOrManufacturer: drugClassificationOrManufacturer ??
          this.drugClassificationOrManufacturer,
      drugImageUrl: drugImageUrl ?? this.drugImageUrl,
    );
  }

  factory ScheduleOverviewState.fromMap(Map<String, dynamic> data) {
    return ScheduleOverviewState(
      id: data['id'],
      takenAt: data['taken_at'],
      isTaken: data['is_taken'],
      drugId: data['drug_id'],
      drugType: data['drug_type'],
      drugName: data['drug_name'],
      drugClassificationOrManufacturer:
          data['drug_classification_or_manufacturer'],
      drugImageUrl: data['drug_image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taken_at': takenAt,
      'is_taken': isTaken,
      'drug_id': drugId,
      'drug_type': drugType,
      'drug_name': drugName,
      'drug_classification_or_manufacturer': drugClassificationOrManufacturer,
      'drug_image_url': drugImageUrl,
    };
  }
}
