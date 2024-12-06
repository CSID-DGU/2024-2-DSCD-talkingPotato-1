class CreateScheduleCondition {
  final int drugId;
  final String time;
  final DateTime currentAppTime;

  CreateScheduleCondition({
    required this.drugId,
    required this.time,
    required this.currentAppTime,
  });
}
