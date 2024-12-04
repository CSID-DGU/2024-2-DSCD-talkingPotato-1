import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/auth/sign_up_by_default_use_case.dart';
import 'package:wooahan/domain/usecase/auth/validate_authentication_code_use_case.dart';
import 'package:wooahan/domain/usecase/auth/validate_email_use_case.dart';
import 'package:wooahan/presentation/view_model/sign_up/sign_up_view_model.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ValidateEmailUseCase>(
      () => ValidateEmailUseCase(),
    );
    Get.lazyPut<ValidateAuthenticationCodeUseCase>(
      () => ValidateAuthenticationCodeUseCase(),
    );
    Get.lazyPut<SignUpByDefaultUseCase>(
      () => SignUpByDefaultUseCase(),
    );

    Get.lazyPut<SignUpViewModel>(() => SignUpViewModel());
  }
}
