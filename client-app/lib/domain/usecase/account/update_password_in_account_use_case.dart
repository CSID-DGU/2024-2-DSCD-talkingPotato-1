import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/account/update_password_in_account_condition.dart';
import 'package:wooahan/domain/repository/account/account_repository.dart';

class UpdatePasswordInAccountUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, UpdatePasswordInAccountCondition> {
  late final AccountRepository _accountRepository;

  @override
  void onInit() {
    super.onInit();

    _accountRepository = Get.find<AccountRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpdatePasswordInAccountCondition condition,
  ) async {
    StateWrapper<void> state = await _accountRepository.updatePasswordInAccount(
      condition,
    );

    return state;
  }
}
