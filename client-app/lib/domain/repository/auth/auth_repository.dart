import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/auth/login_by_default_condition.dart';
import 'package:wooahan/domain/condition/auth/sign_up_by_default_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_authentication_code_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_email_condition.dart';

abstract class AuthRepository {
  Future<StateWrapper<Map<String, dynamic>>> loginByDefault(
    LoginByDefaultCondition condition,
  );

  Future<StateWrapper<Map<String, dynamic>>> signUpByDefault(
    SignUpByDefaultCondition condition,
  );

  Future<StateWrapper<int>> validateEmail(
    ValidateEmailCondition condition,
  );

  Future<StateWrapper<String>> validateAuthenticationCode(
    ValidateAuthenticationCodeCondition condition,
  );

  Future<StateWrapper<void>> logout();

  Future<StateWrapper<void>> withdrawal();
}
