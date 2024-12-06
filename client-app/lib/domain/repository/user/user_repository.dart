import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/condition/user/update_notification_status_in_user_condition.dart';
import 'package:wooahan/domain/condition/user/update_notification_time_in_user_condition.dart';
import 'package:wooahan/domain/entity/user/user_notification_time_state.dart';

abstract class UserRepository {
  Future<bool> saveInformation();

  Future<void> deleteInformation();

  Future<StateWrapper<void>> updateNotificationTime(
    UpdateNotificationTimeInUserCondition condition,
  );

  Future<StateWrapper<void>> updateNotificationStatus(
    UpdateNotificationStatusInUserCondition condition,
  );

  Future<StateWrapper<void>> updateUserDeviceToken(
    UpdateDeviceTokenInUserCondition condition,
  );

  StateWrapper<String> readId();
  StateWrapper<String> readNickname();

  StateWrapper<bool> readNotificationStatus();
  StateWrapper<UserNotificationTimeState> readNotificationTime(String type);
}
