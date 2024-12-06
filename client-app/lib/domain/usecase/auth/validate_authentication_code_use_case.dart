import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/auth/validate_authentication_code_condition.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';

class ValidateAuthenticationCodeUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<String, ValidateAuthenticationCodeCondition> {
  late final AuthRepository _authRepository;

  @override
  void onInit() {
    super.onInit();

    _authRepository = Get.find<AuthRepository>();
  }

  @override
  Future<StateWrapper<String>> execute(
    ValidateAuthenticationCodeCondition condition,
  ) async {
    StateWrapper<String> state =
        await _authRepository.validateAuthenticationCode(condition);

    return state;
  }
}
