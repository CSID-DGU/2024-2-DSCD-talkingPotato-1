import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/auth/auth_provider.dart';

class AuthProviderImpl extends BaseConnect implements AuthProvider {
  @override
  Future<ResponseWrapper> loginByDefault({
    required String serialId,
    required String password,
  }) async {
    FormData formData = FormData({
      'serial_id': serialId,
      'password': password,
    });

    Response response = await post(
      '/auth/login',
      formData,
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> signUpByDefault({
    required String temporaryToken,
    required String nickname,
    required String password,
  }) async {
    Response response = await post(
      '/auth/sign-up',
      {
        'nickname': nickname,
        'password': password,
      },
      query: {
        'role': 'USER',
      },
      headers: {
        ...BaseConnect.notUseBearerToken,
        'Authorization': 'Bearer $temporaryToken',
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> validateEmail({
    required String email,
  }) async {
    Response response = await post(
      '/auth/validations/email',
      {
        'email': email,
      },
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> validateAuthenticationCode({
    required String email,
    required String code,
  }) async {
    Response response = await post(
      '/auth/validations/authentication-code',
      {
        'email': email,
        'authentication_code': code,
      },
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> logout() async {
    Response response = await post(
      '/auth/logout',
      {},
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> withdrawal() async {
    Response response = await post(
      '/auth/withdrawal',
      {},
      headers: BaseConnect.useBearerToken,
    );

    if (!response.hasError) {
      return ResponseWrapper.noContent();
    } else {
      return ResponseWrapper.fromJson(response.body);
    }
  }
}
