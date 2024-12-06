import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/result_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/user/update_notification_status_in_user_condition.dart';
import 'package:wooahan/domain/condition/user/update_notification_time_in_user_condition.dart';
import 'package:wooahan/domain/entity/user/user_notification_time_state.dart';
import 'package:wooahan/domain/usecase/auth/logout_use_case.dart';
import 'package:wooahan/domain/usecase/auth/withdrawal_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_notification_status_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_notification_time_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_notification_status_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_notification_time_in_user_use_case.dart';

class SettingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadNotificationStatusInUserUseCase
      _readNotificationStatusInUserUseCase;
  late final ReadNotificationTimeInUserUseCase
      _readNotificationTimeInUserUseCase;
  late final UpdateNotificationStatusInUserUseCase
      _updateNotificationStatusInUserUseCase;
  late final UpdateNotificationTimeInUserUseCase
      _updateNotificationTimeInUserUseCase;

  late final LogoutUseCase _logoutUseCase;
  late final WithdrawalUseCase _withdrawalUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isAllowedNotification;

  late final Rx<UserNotificationTimeState> _breakfastTime;
  late final Rx<UserNotificationTimeState> _lunchTime;
  late final Rx<UserNotificationTimeState> _dinnerTime;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isAllowedNotification => _isAllowedNotification.value;

  UserNotificationTimeState get breakfastTime => _breakfastTime.value;
  UserNotificationTimeState get lunchTime => _lunchTime.value;
  UserNotificationTimeState get dinnerTime => _dinnerTime.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readNotificationStatusInUserUseCase =
        Get.find<ReadNotificationStatusInUserUseCase>();
    _readNotificationTimeInUserUseCase =
        Get.find<ReadNotificationTimeInUserUseCase>();
    _updateNotificationStatusInUserUseCase =
        Get.find<UpdateNotificationStatusInUserUseCase>();
    _updateNotificationTimeInUserUseCase =
        Get.find<UpdateNotificationTimeInUserUseCase>();

    _logoutUseCase = Get.find<LogoutUseCase>();
    _withdrawalUseCase = Get.find<WithdrawalUseCase>();

    _isAllowedNotification = false.obs;

    _breakfastTime = UserNotificationTimeState(hour: 0, minute: 0).obs;
    _lunchTime = UserNotificationTimeState(hour: 0, minute: 0).obs;
    _dinnerTime = UserNotificationTimeState(hour: 0, minute: 0).obs;
  }

  @override
  void onReady() {
    super.onReady();

    _fetchNotificationStatus();
    _fetchNotificationTime();
  }

  void _fetchNotificationStatus() {
    StateWrapper<bool> response =
        _readNotificationStatusInUserUseCase.execute();

    _isAllowedNotification.value = response.data!;
  }

  void _fetchNotificationTime() {
    List<String> keys = [
      'BREAKFAST',
      'LUNCH',
      'DINNER',
    ];

    for (int i = 0; i < keys.length; i++) {
      StateWrapper<UserNotificationTimeState> response =
          _readNotificationTimeInUserUseCase.execute(keys[i]);

      if (i == 0) {
        _breakfastTime.value = response.data!;
      } else if (i == 1) {
        _lunchTime.value = response.data!;
      } else {
        _dinnerTime.value = response.data!;
      }
    }
  }

  Future<ResultWrapper> updateAllowedNotification() async {
    bool nextIsAllowed = !_isAllowedNotification.value;

    StateWrapper<void> state =
        await _updateNotificationStatusInUserUseCase.execute(
      UpdateNotificationStatusInUserCondition(
          isAllowedNotification: nextIsAllowed),
    );

    if (state.success) {
      _isAllowedNotification.value = nextIsAllowed;
    }

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }

  Future<ResultWrapper> updateNotificationTime(
    String type,
    int hour,
    int minute,
  ) async {
    StateWrapper<void> result =
        await _updateNotificationTimeInUserUseCase.execute(
      UpdateNotificationTimeInUserCondition(
        type: type.toUpperCase(),
        hour: hour,
        minute: minute,
      ),
    );

    switch (type) {
      case 'BREAKFAST':
        _breakfastTime.value = UserNotificationTimeState(
          hour: hour,
          minute: minute,
        );
        break;
      case 'LUNCH':
        _lunchTime.value = UserNotificationTimeState(
          hour: hour,
          minute: minute,
        );
        break;
      case 'DINNER':
        _dinnerTime.value = UserNotificationTimeState(
          hour: hour,
          minute: minute,
        );
        break;
    }

    return ResultWrapper(
      success: result.success,
      message: result.message,
    );
  }

  Future<ResultWrapper> logout() async {
    StateWrapper<void> response = await _logoutUseCase.execute();

    return ResultWrapper(
      success: response.success,
      message: response.message,
    );
  }

  Future<ResultWrapper> withdrawal() async {
    StateWrapper<void> state = await _withdrawalUseCase.execute();

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }
}
