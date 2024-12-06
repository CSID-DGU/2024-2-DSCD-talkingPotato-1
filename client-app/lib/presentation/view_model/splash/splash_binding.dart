import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/user/fetch_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_device_token_in_user_use_case.dart';
import 'package:wooahan/presentation/view_model/splash/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Add your usecase dependencies here
    Get.lazyPut<FetchUserUseCase>(
      () => FetchUserUseCase(),
    );
    Get.lazyPut<UpdateDeviceTokenInUserUseCase>(
      () => UpdateDeviceTokenInUserUseCase(),
    );

    // Add your view model dependencies here
    Get.lazyPut<SplashViewModel>(
      () => SplashViewModel(),
    );
  }
}
