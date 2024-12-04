import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/auth/validate_email_condition.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';

class ValidateEmailUseCase extends BaseUseCase
    implements AsyncConditionUseCase<int, ValidateEmailCondition> {
  late final AuthRepository _authRepository;

  @override
  onInit() {
    super.onInit();

    _authRepository = Get.find<AuthRepository>();
  }

  @override
  Future<StateWrapper<int>> execute(ValidateEmailCondition condition) async {
    StateWrapper<int> state = await _authRepository.validateEmail(condition);

    return state;
  }
}
