class UserNotificationTimeState {
  final int hour;
  final int minute;

  UserNotificationTimeState({
    required this.hour,
    required this.minute,
  });

  UserNotificationTimeState copyWith({
    int? hour,
    int? minute,
  }) {
    return UserNotificationTimeState(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }
}