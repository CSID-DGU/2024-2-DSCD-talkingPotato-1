import 'package:get/get.dart';
import 'package:wooahan/app/utility/validator_util.dart';

class LoginViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late RxString _emailStr;
  late RxString _passwordStr;

  late RxBool _isEnableLoginButton;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  String get emailStr => _emailStr.value;
  String get passwordStr => _passwordStr.value;

  bool get isEnableLoginButton => _isEnableLoginButton.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _emailStr = ''.obs;
    _passwordStr = ''.obs;

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

    print('isValidEmail: $isValidEmail, isValidPassword: $isValidPassword');

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

    print('isValidEmail: $isValidEmail, isValidPassword: $isValidPassword');

    _isEnableLoginButton.value = isValidEmail && isValidPassword;
  }

  loginByDefault() {}
}
