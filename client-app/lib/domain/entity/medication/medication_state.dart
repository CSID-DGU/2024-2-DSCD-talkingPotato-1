class MedicationState {
  final int drugId;
  final String? drugType;
  final String? drugImageUrl;
  final String? drugClassificationOrManufacturer;
  final String? drugName;

  final bool isTakenInBreakfast;
  final bool isTakenInLunch;
  final bool isTakenInDinner;
  final bool isTakenInDaily;

  MedicationState({
    required this.drugId,
    this.drugType,
    this.drugImageUrl,
    this.drugClassificationOrManufacturer,
    this.drugName,
    required this.isTakenInBreakfast,
    required this.isTakenInLunch,
    required this.isTakenInDinner,
    required this.isTakenInDaily,
  });

  MedicationState copyWith({
    int? drugId,
    String? drugType,
    String? drugImageUrl,
    String? drugClassificationOrManufacturer,
    String? drugName,
    bool? isTakenInBreakfast,
    bool? isTakenInLunch,
    bool? isTakenInDinner,
    bool? isTakenInDaily,
  }) {
    return MedicationState(
      drugId: drugId ?? this.drugId,
      drugType: drugType ?? this.drugType,
      drugImageUrl: drugImageUrl ?? this.drugImageUrl,
      drugClassificationOrManufacturer: drugClassificationOrManufacturer ??
          this.drugClassificationOrManufacturer,
      drugName: drugName ?? this.drugName,
      isTakenInBreakfast: isTakenInBreakfast ?? this.isTakenInBreakfast,
      isTakenInLunch: isTakenInLunch ?? this.isTakenInLunch,
      isTakenInDinner: isTakenInDinner ?? this.isTakenInDinner,
      isTakenInDaily: isTakenInDaily ?? this.isTakenInDaily,
    );
  }

  factory MedicationState.fromJson(Map<String, dynamic> json) {
    return MedicationState(
      drugId: json['drug_id'],
      isTakenInBreakfast: json['is_taken_in_breakfast'],
      isTakenInLunch: json['is_taken_in_lunch'],
      isTakenInDinner: json['is_taken_in_dinner'],
      isTakenInDaily: json['is_taken_in_daily'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'drug_id': drugId,
      'is_taken_in_breakfast': isTakenInBreakfast,
      'is_taken_in_lunch': isTakenInLunch,
      'is_taken_in_dinner': isTakenInDinner,
      'is_taken_in_daily': isTakenInDaily,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicationState &&
        other.drugId == drugId &&
        other.isTakenInBreakfast == isTakenInBreakfast &&
        other.isTakenInLunch == isTakenInLunch &&
        other.isTakenInDinner == isTakenInDinner &&
        other.isTakenInDaily == isTakenInDaily;
  }

  @override
  int get hashCode {
    return drugId.hashCode ^
        isTakenInBreakfast.hashCode ^
        isTakenInLunch.hashCode ^
        isTakenInDinner.hashCode ^
        isTakenInDaily.hashCode;
  }
}
