import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/data/provider/user/user_local_provider.dart';
import 'package:wooahan/data/provider/user/user_remote_provider.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/condition/user/update_notification_status_in_user_condition.dart';
import 'package:wooahan/domain/condition/user/update_notification_time_in_user_condition.dart';
import 'package:wooahan/domain/entity/user/user_notification_time_state.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class UserRepositoryImpl extends GetxService implements UserRepository {
  late final UserLocalProvider _localProvider;
  late final UserRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _localProvider = StorageFactory.userLocalProvider;
    _remoteProvider = Get.find<UserRemoteProvider>();
  }

  @override
  Future<bool> saveInformation() async {
    ResponseWrapper response = await _remoteProvider.getInformation();

    if (!response.success) {
      return false;
    }

    Map<String, dynamic> data = response.data!;

    String breakfastTime = data['breakfast_time'];
    String lunchTime = data['lunch_time'];
    String dinnerTime = data['dinner_time'];

    await _localProvider.allocateAll(
      id: data['id'],
      nickname: data['nickname'],
      isAllowedNotification: data['is_allowed_notification'],
      breakfastHour: int.parse(breakfastTime.split(':')[0]),
      breakfastMinute: int.parse(breakfastTime.split(':')[1]),
      lunchHour: int.parse(lunchTime.split(':')[0]),
      lunchMinute: int.parse(lunchTime.split(':')[1]),
      dinnerHour: int.parse(dinnerTime.split(':')[0]),
      dinnerMinute: int.parse(dinnerTime.split(':')[1]),
    );

    return true;
  }

  @override
  Future<void> deleteInformation() async {
    await _localProvider.deallocateAll();
  }

  @override
  Future<StateWrapper<void>> updateNotificationStatus(
    UpdateNotificationStatusInUserCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.putNotificationStatus(
      isAllowedNotification: condition.isAllowedNotification,
    );

    _localProvider.setAllowedNotification(condition.isAllowedNotification);

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }

  @override
  Future<StateWrapper<void>> updateNotificationTime(
    UpdateNotificationTimeInUserCondition condition,
  ) async {
    String processingTime =
        '${condition.hour.toString().padLeft(2, '0')}:${condition.minute.toString().padLeft(2, '0')}';

    ResponseWrapper response = await _remoteProvider.putNotificationTime(
      type: condition.type,
      time: processingTime,
    );

    if (!response.success) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    switch (condition.type.toUpperCase()) {
      case 'BREAKFAST':
        _localProvider.setBreakfastHour(condition.hour);
        _localProvider.setBreakfastMinute(condition.minute);
        break;
      case 'LUNCH':
        _localProvider.setLunchHour(condition.hour);
        _localProvider.setLunchMinute(condition.minute);
        break;
      case 'DINNER':
        _localProvider.setDinnerHour(condition.hour);
        _localProvider.setDinnerMinute(condition.minute);
        break;
      default:
        throw Exception('Invalid type');
    }

    return StateWrapper(
      success: true,
    );
  }

  @override
  Future<StateWrapper<void>> updateUserDeviceToken(
    UpdateDeviceTokenInUserCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.putDeviceToken(
      deviceToken: condition.deviceToken,
    );

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }

  @override
  StateWrapper<String> readId() {
    return StateWrapper(
      success: true,
      data: _localProvider.getId(),
    );
  }

  @override
  StateWrapper<String> readNickname() {
    return StateWrapper(
      success: true,
      data: _localProvider.getNickname(),
    );
  }

  @override
  StateWrapper<bool> readNotificationStatus() {
    return StateWrapper(
      success: true,
      data: _localProvider.getAllowedNotification(),
    );
  }

  @override
  StateWrapper<UserNotificationTimeState> readNotificationTime(String type) {
    switch (type.toUpperCase()) {
      case 'BREAKFAST':
        return StateWrapper(
          success: true,
          data: UserNotificationTimeState(
            hour: _localProvider.getBreakfastHour(),
            minute: _localProvider.getBreakfastMinute(),
          ),
        );
      case 'LUNCH':
        return StateWrapper(
          success: true,
          data: UserNotificationTimeState(
            hour: _localProvider.getLunchHour(),
            minute: _localProvider.getLunchMinute(),
          ),
        );
      case 'DINNER':
        return StateWrapper(
          success: true,
          data: UserNotificationTimeState(
            hour: _localProvider.getDinnerHour(),
            minute: _localProvider.getDinnerMinute(),
          ),
        );
      default:
        throw Exception('Invalid type');
    }
  }
}
