class ScheduleDetailState {
  final bool isTaken;

  final int drugId;
  final String drugType;
  final String drugName;
  final String? drugClassificationOrManufacturer;
  final String? drugImageUrl;

  ScheduleDetailState({
    required this.isTaken,
    required this.drugId,
    required this.drugType,
    required this.drugName,
    this.drugClassificationOrManufacturer,
    this.drugImageUrl,
  });

  ScheduleDetailState copyWith({
    bool? isTaken,
    int? drugId,
    String? drugType,
    String? drugName,
    String? drugClassificationOrManufacturer,
    String? drugImageUrl,
  }) {
    return ScheduleDetailState(
      isTaken: isTaken ?? this.isTaken,
      drugId: drugId ?? this.drugId,
      drugType: drugType ?? this.drugType,
      drugName: drugName ?? this.drugName,
      drugClassificationOrManufacturer: drugClassificationOrManufacturer ??
          this.drugClassificationOrManufacturer,
      drugImageUrl: drugImageUrl ?? this.drugImageUrl,
    );
  }

  factory ScheduleDetailState.fromJson(Map<String, dynamic> data) {
    return ScheduleDetailState(
      isTaken: data['is_taken'],
      drugId: data['drug_id'],
      drugType: data['drug_type'],
      drugName: data['drug_name'],
      drugClassificationOrManufacturer:
          data['drug_classification_or_manufacturer'],
      drugImageUrl: data['drug_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_taken': isTaken,
      'drug_id': drugId,
      'drug_type': drugType,
      'drug_name': drugName,
      'drug_classification_or_manufacturer': drugClassificationOrManufacturer,
      'drug_image_url': drugImageUrl,
    };
  }
}
