// ignore_for_file: constant_identifier_names

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/utility/validator_util.dart';
import 'package:wooahan/core/wrapper/result_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/auth/sign_up_by_default_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_authentication_code_condition.dart';
import 'package:wooahan/domain/condition/auth/validate_email_condition.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/usecase/auth/sign_up_by_default_use_case.dart';
import 'package:wooahan/domain/usecase/auth/validate_authentication_code_use_case.dart';
import 'package:wooahan/domain/usecase/auth/validate_email_use_case.dart';
import 'package:wooahan/domain/usecase/user/update_device_token_in_user_use_case.dart';

class SignUpViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* Static Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */

  late final PageController pageController;

  late final String temporaryToken;

  late final SignUpByDefaultUseCase _signUpByDefaultUseCase;

  late final ValidateEmailUseCase _validateEmailUseCase;
  late final ValidateAuthenticationCodeUseCase
      _validateAuthenticationCodeUseCase;
  late final UpdateDeviceTokenInUserUseCase _updateDeviceTokenInUserUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isEnableInEmailInput;
  late final RxBool _isEnableInPasswordInput;
  late final RxBool _isEnableInNicknameInput;
  late final RxBool _isEnableInCompletedSignUp;

  late final Rx<EmailInputState> _emailInput;
  late final Rx<PasswordInputState> _passwordInput;
  late final Rx<NicknameInputState> _nicknameInput;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isEnableInEmailInput => _isEnableInEmailInput.value;
  bool get isEnableInPasswordInput => _isEnableInPasswordInput.value;
  bool get isEnableInNicknameInput => _isEnableInNicknameInput.value;
  bool get isEnableInCompletedSignUp => _isEnableInCompletedSignUp.value;

  EmailInputState get emailInput => _emailInput.value;
  PasswordInputState get passwordInput => _passwordInput.value;
  NicknameInputState get nicknameInput => _nicknameInput.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: 0);

    _signUpByDefaultUseCase = Get.find<SignUpByDefaultUseCase>();
    _validateEmailUseCase = Get.find<ValidateEmailUseCase>();
    _validateAuthenticationCodeUseCase =
        Get.find<ValidateAuthenticationCodeUseCase>();
    _updateDeviceTokenInUserUseCase =
        Get.find<UpdateDeviceTokenInUserUseCase>();

    _isEnableInEmailInput = false.obs;
    _isEnableInPasswordInput = false.obs;
    _isEnableInNicknameInput = false.obs;
    _isEnableInCompletedSignUp = false.obs;

    _emailInput = EmailInputState.initial().obs;
    _passwordInput = PasswordInputState.initial().obs;
    _nicknameInput = NicknameInputState.initial().obs;
  }

  @override
  void dispose() {
    super.dispose();

    pageController.dispose();
  }

  void updateEmail(String email) {
    _emailInput.value = _emailInput.value.copyWith(
      serialEmail: email,
    );

    if (ValidatorUtil.isValidEmail(email)) {
      _emailInput.value = _emailInput.value.copyWith(
        status: EmailInputState.VALID_EMAIL,
      );
    } else {
      _emailInput.value = _emailInput.value.copyWith(
        status: EmailInputState.INVALID_EMAIL,
      );
    }
  }

  void updateAuthenticationCode(String code) {
    _emailInput.value = _emailInput.value.copyWith(
      authenticationCode: code,
    );

    if (code.length == 6) {
      _emailInput.value = _emailInput.value.copyWith(
        status: EmailInputState.VALID_AUTHENTICATION_CODE,
      );
    } else {
      _emailInput.value = _emailInput.value.copyWith(
        status: EmailInputState.INVALID_AUTHENTICATION_CODE,
      );
    }
  }

  Future<ResultWrapper> validateSerialEmail() async {
    StateWrapper<int> state = await _validateEmailUseCase.execute(
      ValidateEmailCondition(
        email: _emailInput.value.serialEmail,
      ),
    );

    if (state.success) {
      _emailInput.value = _emailInput.value.copyWith(
        isEnabledSerialEmail: false,
        status: EmailInputState.INVALID_AUTHENTICATION_CODE,
      );
    }

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }

  Future<ResultWrapper> validateAuthenticationCode() async {
    StateWrapper<String> state =
        await _validateAuthenticationCodeUseCase.execute(
      ValidateAuthenticationCodeCondition(
        email: _emailInput.value.serialEmail,
        code: _emailInput.value.authenticationCode,
      ),
    );

    if (state.success) {
      _emailInput.value = _emailInput.value.copyWith(
        isEnabledAuthenticationCode: false,
        status: EmailInputState.FINISH,
      );

      temporaryToken = state.data!;

      _isEnableInEmailInput.value = true;
    }

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }

  void updateWantPassword(String password) {
    _passwordInput.value = _passwordInput.value.copyWith(
      wantString: password,
    );

    if (ValidatorUtil.isValidPassword(password) &&
        password == _passwordInput.value.validateString) {
      _isEnableInPasswordInput.value = true;
    } else {
      _isEnableInPasswordInput.value = false;
    }
  }

  void updateValidatePassword(String password) {
    _passwordInput.value = _passwordInput.value.copyWith(
      validateString: password,
    );

    if (ValidatorUtil.isValidPassword(password) &&
        password == _passwordInput.value.wantString) {
      _isEnableInPasswordInput.value = true;
    } else {
      _isEnableInPasswordInput.value = false;
    }
  }

  void updateNickname(String nickname) {
    _nicknameInput.value = _nicknameInput.value.copyWith(
      nickname: nickname,
    );

    if (nickname.isEmpty) {
      _isEnableInNicknameInput.value = false;

      return;
    }

    if (!ValidatorUtil.isValidNickname(nickname)) {
      _isEnableInNicknameInput.value = false;

      return;
    }

    _isEnableInNicknameInput.value = true;
  }

  Future<ResultWrapper> createAccount() async {
    StateWrapper<void> state = await _signUpByDefaultUseCase.execute(
      SignUpByDefaultCondition(
        temporaryToken: temporaryToken,
        nickname: _nicknameInput.value.nickname,
        password: _passwordInput.value.wantString,
      ),
    );

    if (state.success) {
      await _updateDeviceToken();

      _isEnableInCompletedSignUp.value = true;
    }

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }

  Future<void> _updateDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();

    await _updateDeviceTokenInUserUseCase.execute(
      UpdateDeviceTokenInUserCondition(
        deviceToken: token!,
      ),
    );
  }
}

class EmailInputState {
  static const String INVALID_EMAIL = "INVALID_EMAIL";
  static const String VALID_EMAIL = "VALID_EMAIL";
  static const String INVALID_AUTHENTICATION_CODE =
      "INVALID_AUTHENTICATION_CODE";
  static const String VALID_AUTHENTICATION_CODE = "VALID_AUTHENTICATION_CODE";
  static const String FINISH = "FINISH";

  final String serialEmail;
  final String authenticationCode;

  final bool isEnabledSerialEmail;
  final bool isEnabledAuthenticationCode;
  final String status;

  String get statusTitle {
    switch (status) {
      case INVALID_EMAIL:
        return "인증 메일 전송";
      case VALID_EMAIL:
        return "인증 메일 전송";
      case INVALID_AUTHENTICATION_CODE:
        return "인증하기";
      case VALID_AUTHENTICATION_CODE:
        return "인증하기";
      case FINISH:
        return "인증완료";
      default:
        throw UnimplementedError("Not Exist status: $status");
    }
  }

  EmailInputState({
    required this.serialEmail,
    required this.authenticationCode,
    required this.isEnabledSerialEmail,
    required this.isEnabledAuthenticationCode,
    required this.status,
  });

  EmailInputState copyWith({
    String? serialEmail,
    String? authenticationCode,
    bool? isEnabledSerialEmail,
    bool? isEnabledAuthenticationCode,
    String? status,
  }) {
    return EmailInputState(
      serialEmail: serialEmail ?? this.serialEmail,
      authenticationCode: authenticationCode ?? this.authenticationCode,
      isEnabledSerialEmail: isEnabledSerialEmail ?? this.isEnabledSerialEmail,
      isEnabledAuthenticationCode:
          isEnabledAuthenticationCode ?? this.isEnabledAuthenticationCode,
      status: status ?? this.status,
    );
  }

  factory EmailInputState.initial() {
    return EmailInputState(
      serialEmail: "",
      authenticationCode: "",
      isEnabledSerialEmail: true,
      isEnabledAuthenticationCode: true,
      status: INVALID_EMAIL,
    );
  }
}

class PasswordInputState {
  final String wantString;
  final String validateString;

  PasswordInputState({
    required this.wantString,
    required this.validateString,
  });

  PasswordInputState copyWith({
    String? wantString,
    String? validateString,
  }) {
    return PasswordInputState(
      wantString: wantString ?? this.wantString,
      validateString: validateString ?? this.validateString,
    );
  }

  factory PasswordInputState.initial() {
    return PasswordInputState(
      wantString: "",
      validateString: "",
    );
  }
}

class NicknameInputState {
  final String nickname;

  NicknameInputState({
    required this.nickname,
  });

  NicknameInputState copyWith({
    String? nickname,
  }) {
    return NicknameInputState(
      nickname: nickname ?? this.nickname,
    );
  }

  factory NicknameInputState.initial() {
    return NicknameInputState(
      nickname: "",
    );
  }
}
