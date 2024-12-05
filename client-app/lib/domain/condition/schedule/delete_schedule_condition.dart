class DeleteScheduleCondition {
  final int drugId;
  final String time;
  final DateTime currentAppTime;

  DeleteScheduleCondition({
    required this.drugId,
    required this.time,
    required this.currentAppTime,
  });
}
