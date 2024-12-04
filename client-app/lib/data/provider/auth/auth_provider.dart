import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class AuthProvider {
  Future<ResponseWrapper> loginByDefault({
    required String serialId,
    required String password,
  });

  Future<ResponseWrapper> signUpByDefault({
    required String temporaryToken,
    required String nickname,
    required String password,
  });

  Future<ResponseWrapper> validateEmail({
    required String email,
  });

  Future<ResponseWrapper> validateAuthenticationCode({
    required String email,
    required String code,
  });

  Future<ResponseWrapper> withdrawal();

  Future<ResponseWrapper> logout();
}
