import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/auth/login_by_default_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_device_token_in_user_use_case.dart';
import 'package:wooahan/presentation/view_model/login/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginByDefaultUseCase>(
      () => LoginByDefaultUseCase(),
    );
    Get.lazyPut<UpdateDeviceTokenInUserUseCase>(
      () => UpdateDeviceTokenInUserUseCase(),
    );

    Get.lazyPut<LoginViewModel>(
      () => LoginViewModel(),
    );
  }
}
