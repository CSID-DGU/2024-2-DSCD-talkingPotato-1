import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class UserRemoteProvider {
  Future<ResponseWrapper> getInformation();

  Future<ResponseWrapper> putNotificationTime({
    required String type,
    required String time,
  });

  Future<ResponseWrapper> putNotificationStatus({
    required bool isAllowedNotification,
  });

  Future<ResponseWrapper> putDeviceToken({
    required String deviceToken,
  });
}
