import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/data/provider/system/system_provider.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/usecase/user/fetch_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_device_token_in_user_use_case.dart';

class SplashViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* Static Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final FetchUserUseCase _fetchUserUseCase;
  late final UpdateDeviceTokenInUserUseCase _updateDeviceTokenInUserUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxString _informationText;
  late final RxBool _isConnectedToInternet;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get informationText => _informationText.value;
  bool get isConnectedToInternet => _isConnectedToInternet.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _informationText = '우아한을 시작합니다\n'.obs;
    _isConnectedToInternet = true.obs;

    _fetchUserUseCase = Get.find<FetchUserUseCase>();
    _updateDeviceTokenInUserUseCase =
        Get.find<UpdateDeviceTokenInUserUseCase>();
  }

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(milliseconds: 500));

    checkDevice();
  }

  void checkDevice() async {
    _isConnectedToInternet.value = true;

    _informationText.value = '인터넷 연결을 확인합니다\n';
    await Future.delayed(const Duration(milliseconds: 750));
    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    // Guard Clause - Not Connected to Internet
    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.wifi) &&
        !connectivityResult.contains(ConnectivityResult.ethernet)) {
      _informationText.value = '인터넷이 연결되어있지 않습니다\n 인터넷 연결 후 다시 시도해주세요';
      _isConnectedToInternet.value = false;

      return;
    }

    _informationText.value = '이전 로그인 정보을 확인합니다\n';
    await Future.delayed(const Duration(milliseconds: 750));
    SystemProvider systemProvider = StorageFactory.systemProvider;

    if (systemProvider.isLogin) {
      StateWrapper<void> userState = await _fetchUserUseCase.execute();

      if (userState.success) {
        String? token = await FirebaseMessaging.instance.getToken();

        await _updateDeviceTokenInUserUseCase.execute(
          UpdateDeviceTokenInUserCondition(deviceToken: token!),
        );
      } else {
        Get.snackbar(
          "로그인 만료",
          "로그인이 만료되었습니다. 다시 로그인해주세요.",
        );

        Get.toNamed(AppRoutes.LOGIN);

        return;
      }
    }

    _informationText.value = '건강한 하루 되세요\n';

    await Future.delayed(const Duration(milliseconds: 500));

    Get.offAndToNamed(AppRoutes.ROOT);
  }
}
