abstract class UserLocalProvider {
  /* ------------------------------------------------------------ */
  /* Initialize ------------------------------------------------- */
  /* ------------------------------------------------------------ */
  Future<void> allocateAll({
    required String? id,
    required String nickname,
    required bool isAllowedNotification,
    required int breakfastHour,
    required int breakfastMinute,
    required int lunchHour,
    required int lunchMinute,
    required int dinnerHour,
    required int dinnerMinute,
  });
  Future<void> deallocateAll();

  /* ------------------------------------------------------------ */
  /* Getter ----------------------------------------------------- */
  /* ------------------------------------------------------------ */
  String getId();
  String getNickname();

  bool getAllowedNotification();

  int getBreakfastHour();
  int getBreakfastMinute();
  int getLunchHour();
  int getLunchMinute();
  int getDinnerHour();
  int getDinnerMinute();

  /* ------------------------------------------------------------ */
  /* Setter ----------------------------------------------------- */
  /* ------------------------------------------------------------ */
  Future<void> setId(String id);
  Future<void> setNickname(String nickname);

  Future<void> setAllowedNotification(bool isAllowedNotification);

  Future<void> setBreakfastHour(int hour);
  Future<void> setBreakfastMinute(int minute);
  Future<void> setLunchHour(int hour);
  Future<void> setLunchMinute(int minute);
  Future<void> setDinnerHour(int hour);
  Future<void> setDinnerMinute(int minute);
}

extension UserLocalProviderExt on UserLocalProvider {
  // Default Information Attribute
  static const String id = "id";
  static const String nickname = "nickname";

  // Notification Enable Information Attribute
  static const String isAllowedNotification = "isAllowedNotification";

  // Notification Time Information Attribute
  static const String breakfastHour = "breakfastHour";
  static const String breakfastMinute = "breakfastMinute";
  static const String lunchHour = "lunchHour";
  static const String lunchMinute = "lunchMinute";
  static const String dinnerHour = "dinnerHour";
  static const String dinnerMinute = "dinnerMinute";
}
