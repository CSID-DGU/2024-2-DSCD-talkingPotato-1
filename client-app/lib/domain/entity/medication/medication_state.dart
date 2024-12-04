class MedicationState {
  final int drugId;
  final String drugType;
  final String? drugImage;
  final String drugClassificationOrManufacturer;
  final String drugName;

  final bool isTakenInBreakfast;
  final bool isTakenInLunch;
  final bool isTakenInDinner;
  final bool isTakenInDaily;

  MedicationState({
    required this.drugId,
    required this.drugType,
    this.drugImage,
    required this.drugClassificationOrManufacturer,
    required this.drugName,
    required this.isTakenInBreakfast,
    required this.isTakenInLunch,
    required this.isTakenInDinner,
    required this.isTakenInDaily,
  });

  MedicationState copyWith({
    int? drugId,
    String? drugType,
    String? drugImage,
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
      drugImage: drugImage ?? this.drugImage,
      drugClassificationOrManufacturer: drugClassificationOrManufacturer ??
          this.drugClassificationOrManufacturer,
      drugName: drugName ?? this.drugName,
      isTakenInBreakfast: isTakenInBreakfast ?? this.isTakenInBreakfast,
      isTakenInLunch: isTakenInLunch ?? this.isTakenInLunch,
      isTakenInDinner: isTakenInDinner ?? this.isTakenInDinner,
      isTakenInDaily: isTakenInDaily ?? this.isTakenInDaily,
    );
  }
}
