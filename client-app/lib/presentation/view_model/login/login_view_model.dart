import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/utility/validator_util.dart';
import 'package:wooahan/core/wrapper/result_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/auth/login_by_default_condition.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/usecase/auth/login_by_default_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_device_token_in_user_use_case.dart';

class LoginViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final LoginByDefaultUseCase _loginByDefaultUseCase;
  late final UpdateDeviceTokenInUserUseCase _updateDeviceTokenInUserUsecase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxString _emailStr;
  late final RxString _passwordStr;

  late final RxBool _isLoadingByLogin;
  late final RxBool _isEnableLoginButton;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get emailStr => _emailStr.value;
  String get passwordStr => _passwordStr.value;

  bool get isLoadingByLogin => _isLoadingByLogin.value;
  bool get isEnableLoginButton => _isEnableLoginButton.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _loginByDefaultUseCase = Get.find<LoginByDefaultUseCase>();
    _updateDeviceTokenInUserUsecase =
        Get.find<UpdateDeviceTokenInUserUseCase>();

    _emailStr = ''.obs;
    _passwordStr = ''.obs;

    _isLoadingByLogin = false.obs;
    _isEnableLoginButton = false.obs;
  }

  void updateEmail(String value) {
    if (value.isEmpty) {
      _emailStr.value = value;
      _isEnableLoginButton.value = false;

      return;
    }

    _emailStr.value = value;

    bool isValidEmail =
        _emailStr.value.isNotEmpty && ValidatorUtil.isValidEmail(value);

    bool isValidPassword =
        _passwordStr.value.isNotEmpty && _passwordStr.value.length >= 8;

    _isEnableLoginButton.value = isValidEmail && isValidPassword;
  }

  void updatePassword(String value) {
    if (value.isEmpty) {
      _passwordStr.value = value;
      _isEnableLoginButton.value = false;

      return;
    }

    _passwordStr.value = value;

    bool isValidEmail = _emailStr.value.isNotEmpty &&
        ValidatorUtil.isValidEmail(_emailStr.value);

    bool isValidPassword =
        _passwordStr.value.isNotEmpty && _passwordStr.value.length >= 8;

    _isEnableLoginButton.value = isValidEmail && isValidPassword;
  }

  Future<ResultWrapper> login() async {
    _isLoadingByLogin.value = true;

    StateWrapper<void> result = await _loginByDefaultUseCase.execute(
      LoginByDefaultCondition(
        email: _emailStr.value,
        password: _passwordStr.value,
      ),
    );

    if (result.success) {
      await _updateDeviceToken();
    }

    _isLoadingByLogin.value = false;

    return ResultWrapper(
      success: result.success,
      message: result.message,
    );
  }

  Future<void> _updateDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    await _updateDeviceTokenInUserUsecase.execute(
      UpdateDeviceTokenInUserCondition(
        deviceToken: token!,
      ),
    );
  }
}
