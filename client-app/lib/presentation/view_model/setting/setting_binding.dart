import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/auth/logout_use_case.dart';
import 'package:wooahan/domain/usecase/auth/withdrawal_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_notification_status_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_notification_time_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_notification_status_in_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_notification_time_in_user_use_case.dart';
import 'package:wooahan/presentation/view_model/setting/setting_view_model.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadNotificationStatusInUserUseCase>(
      () => ReadNotificationStatusInUserUseCase(),
    );
    Get.lazyPut<ReadNotificationTimeInUserUseCase>(
      () => ReadNotificationTimeInUserUseCase(),
    );
    Get.lazyPut<UpdateNotificationStatusInUserUseCase>(
      () => UpdateNotificationStatusInUserUseCase(),
    );
    Get.lazyPut<UpdateNotificationTimeInUserUseCase>(
      () => UpdateNotificationTimeInUserUseCase(),
    );
    Get.lazyPut<LogoutUseCase>(
      () => LogoutUseCase(),
    );
    Get.lazyPut<WithdrawalUseCase>(
      () => WithdrawalUseCase(),
    );

    Get.lazyPut<SettingViewModel>(() => SettingViewModel());
  }
}
