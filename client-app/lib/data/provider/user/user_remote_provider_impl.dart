import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/user/user_remote_provider.dart';

class UserRemoteProviderImpl extends BaseConnect implements UserRemoteProvider {
  @override
  Future<ResponseWrapper> getInformation() async {
    Response response = await get(
      '/api/v1/users',
      headers: {
        ...BaseConnect.useBearerToken,
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> putNotificationTime({
    required String type,
    required String time,
  }) async {
    Response response = await put(
      '/api/v1/users/notification-time',
      {
        'type': type,
        'time': time,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> putNotificationStatus({
    required bool isAllowedNotification,
  }) async {
    Response response = await put(
      '/api/v1/users/notification-status',
      {
        'is_allowed_notification': isAllowedNotification,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> putDeviceToken({
    required String deviceToken,
  }) async {
    Response response = await put(
      '/api/v1/users/device-token',
      {
        'device_token': deviceToken,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
