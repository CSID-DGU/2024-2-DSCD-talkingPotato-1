class ReadDrugSummaryCondition {
  final int drugId;
  final String? customName;

  ReadDrugSummaryCondition({
    required this.drugId,
    this.customName,
  });

  factory ReadDrugSummaryCondition.drug(int drugId) {
    return ReadDrugSummaryCondition(
      drugId: drugId,
      customName: null,
    );
  }

  factory ReadDrugSummaryCondition.custom(String customName) {
    return ReadDrugSummaryCondition(
      drugId: -1,
      customName: customName,
    );
  }
}
