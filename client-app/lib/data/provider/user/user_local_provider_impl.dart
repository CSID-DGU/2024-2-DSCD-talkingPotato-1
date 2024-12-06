import 'package:get_storage/get_storage.dart';
import 'package:wooahan/data/provider/user/user_local_provider.dart';

class UserLocalProviderImpl implements UserLocalProvider {
  UserLocalProviderImpl({
    required GetStorage storage,
  }) : _storage = storage;

  final GetStorage _storage;

  @override
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
  }) async {
    if (id != null) {
      await _storage.write(UserLocalProviderExt.id, id);
    }
    await _storage.write(UserLocalProviderExt.nickname, nickname);

    await _storage.write(
      UserLocalProviderExt.isAllowedNotification,
      isAllowedNotification,
    );

    await _storage.write(UserLocalProviderExt.breakfastHour, breakfastHour);
    await _storage.write(UserLocalProviderExt.breakfastMinute, breakfastMinute);
    await _storage.write(UserLocalProviderExt.lunchHour, lunchHour);
    await _storage.write(UserLocalProviderExt.lunchMinute, lunchMinute);
    await _storage.write(UserLocalProviderExt.dinnerHour, dinnerHour);
    await _storage.write(UserLocalProviderExt.dinnerMinute, dinnerMinute);
  }

  @override
  Future<void> deallocateAll() async {
    await _storage.remove(UserLocalProviderExt.id);
    await _storage.remove(UserLocalProviderExt.nickname);

    await _storage.remove(UserLocalProviderExt.isAllowedNotification);

    await _storage.remove(UserLocalProviderExt.breakfastHour);
    await _storage.remove(UserLocalProviderExt.breakfastMinute);
    await _storage.remove(UserLocalProviderExt.lunchHour);
    await _storage.remove(UserLocalProviderExt.lunchMinute);
    await _storage.remove(UserLocalProviderExt.dinnerHour);
    await _storage.remove(UserLocalProviderExt.dinnerMinute);
  }

  /* ------------------------------------------------------------ */
  /* Getter ----------------------------------------------------- */
  /* ------------------------------------------------------------ */
  @override
  String getId() {
    return _storage.read(UserLocalProviderExt.id)!;
  }

  @override
  String getNickname() {
    return _storage.read(UserLocalProviderExt.nickname)!;
  }

  @override
  bool getAllowedNotification() {
    return _storage.read(UserLocalProviderExt.isAllowedNotification)!;
  }

  @override
  int getBreakfastHour() {
    return _storage.read(UserLocalProviderExt.breakfastHour)!;
  }

  @override
  int getBreakfastMinute() {
    return _storage.read(UserLocalProviderExt.breakfastMinute)!;
  }

  @override
  int getLunchHour() {
    return _storage.read(UserLocalProviderExt.lunchHour)!;
  }

  @override
  int getLunchMinute() {
    return _storage.read(UserLocalProviderExt.lunchMinute)!;
  }

  @override
  int getDinnerHour() {
    return _storage.read(UserLocalProviderExt.dinnerHour)!;
  }

  @override
  int getDinnerMinute() {
    return _storage.read(UserLocalProviderExt.dinnerMinute)!;
  }

  /* ------------------------------------------------------------ */
  /* Setter ----------------------------------------------------- */
  /* ------------------------------------------------------------ */
  @override
  Future<void> setId(String encryptedId) async {
    await _storage.write(UserLocalProviderExt.id, encryptedId);
  }

  @override
  Future<void> setNickname(String nickname) async {
    await _storage.write(UserLocalProviderExt.nickname, nickname);
  }

  @override
  Future<void> setAllowedNotification(
    bool isEnabledNotification,
  ) async {
    await _storage.write(
      UserLocalProviderExt.isAllowedNotification,
      isEnabledNotification,
    );
  }

  @override
  Future<void> setBreakfastHour(int hour) async {
    await _storage.write(UserLocalProviderExt.breakfastHour, hour);
  }

  @override
  Future<void> setBreakfastMinute(int minute) async {
    await _storage.write(UserLocalProviderExt.breakfastMinute, minute);
  }

  @override
  Future<void> setLunchHour(int hour) async {
    await _storage.write(UserLocalProviderExt.lunchHour, hour);
  }

  @override
  Future<void> setLunchMinute(int minute) async {
    await _storage.write(UserLocalProviderExt.lunchMinute, minute);
  }

  @override
  Future<void> setDinnerHour(int hour) async {
    await _storage.write(UserLocalProviderExt.dinnerHour, hour);
  }

  @override
  Future<void> setDinnerMinute(int minute) async {
    await _storage.write(UserLocalProviderExt.dinnerMinute, minute);
  }
}
