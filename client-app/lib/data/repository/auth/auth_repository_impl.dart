import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/auth/auth_provider.dart';
import 'package:wooahan/domain/condition/auth/login_by_default_condition.dart';
import 'package:wooahan/domain/condition/auth/sign_up_by_default_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_authentication_code_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_email_condition.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';

class AuthRepositoryImpl extends GetxService implements AuthRepository {
  late final AuthProvider _authProvider;

  @override
  void onInit() {
    super.onInit();

    _authProvider = Get.find<AuthProvider>();
  }

  @override
  Future<StateWrapper<Map<String, dynamic>>> loginByDefault(
    LoginByDefaultCondition condition,
  ) async {
    ResponseWrapper response = await _authProvider.loginByDefault(
      serialId: condition.email,
      password: condition.password,
    );

    Map<String, dynamic>? data = response.data;

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: data,
    );
  }

  @override
  Future<StateWrapper<Map<String, dynamic>>> signUpByDefault(
    SignUpByDefaultCondition condition,
  ) async {
    ResponseWrapper response = await _authProvider.signUpByDefault(
      temporaryToken: condition.temporaryToken,
      nickname: condition.nickname,
      password: condition.password,
    );

    Map<String, dynamic>? data = response.data;

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: data,
    );
  }

  @override
  Future<StateWrapper<int>> validateEmail(
    ValidateEmailCondition condition,
  ) async {
    ResponseWrapper response = await _authProvider.validateEmail(
      email: condition.email,
    );

    int? state = response.data?['try_cnt'];

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: state,
    );
  }

  @override
  Future<StateWrapper<String>> validateAuthenticationCode(
    ValidateAuthenticationCodeCondition condition,
  ) async {
    ResponseWrapper response = await _authProvider.validateAuthenticationCode(
      email: condition.email,
      code: condition.code,
    );

    String? state = response.data?['temporary_token'];

    return StateWrapper(
      success: response.success,
      message: response.message,
      data: state,
    );
  }

  @override
  Future<StateWrapper<void>> logout() async {
    ResponseWrapper response = await _authProvider.logout();

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }

  @override
  Future<StateWrapper<void>> withdrawal() async {
    ResponseWrapper response = await _authProvider.withdrawal();

    return StateWrapper(
      success: response.success,
      message: response.message,
    );
  }
}
