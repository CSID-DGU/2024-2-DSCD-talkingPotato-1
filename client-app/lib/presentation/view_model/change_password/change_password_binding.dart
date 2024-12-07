import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/account/update_password_in_account_use_case.dart';
import 'package:wooahan/presentation/view_model/change_password/change_password_view_model.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdatePasswordInAccountUseCase>(
      () => UpdatePasswordInAccountUseCase(),
    );

    Get.lazyPut<ChangePasswordViewModel>(
      () => ChangePasswordViewModel(),
    );
  }
}
