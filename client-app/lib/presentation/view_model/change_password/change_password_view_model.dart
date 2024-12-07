import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/utility/validator_util.dart';
import 'package:wooahan/core/wrapper/result_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/account/update_password_in_account_condition.dart';
import 'package:wooahan/domain/usecase/account/update_password_in_account_use_case.dart';
import 'package:wooahan/presentation/view_model/sign_up/sign_up_view_model.dart';

class ChangePasswordViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final PageController pageController;
  late final UpdatePasswordInAccountUseCase _updatePasswordInAccountUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isEnableInPasswordInput;
  late final RxBool _isEnableInCompleted;

  late final Rx<PasswordInputState> _passwordInput;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isEnableInPasswordInput => _isEnableInPasswordInput.value;
  bool get isEnableInCompleted => _isEnableInCompleted.value;

  PasswordInputState get passwordInput => _passwordInput.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    pageController = PageController();

    _updatePasswordInAccountUseCase =
        Get.find<UpdatePasswordInAccountUseCase>();

    _isEnableInPasswordInput = false.obs;
    _isEnableInCompleted = false.obs;

    _passwordInput = PasswordInputState.initial().obs;
  }

  @override
  void onClose() {
    super.onClose();

    pageController.dispose();
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

  Future<ResultWrapper> onTapConfirmButton() async {
    StateWrapper<void> state = await _updatePasswordInAccountUseCase.execute(
      UpdatePasswordInAccountCondition(
        password: _passwordInput.value.wantString,
      ),
    );

    _isEnableInCompleted.value = state.success;

    return ResultWrapper(
      success: state.success,
      message: state.message,
    );
  }
}
