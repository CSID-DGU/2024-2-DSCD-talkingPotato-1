import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_no_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class WithdrawalUseCase extends BaseUseCase
    implements AsyncNoConditionUseCase<void> {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _authRepository = Get.find<AuthRepository>();
    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute() async {
    StateWrapper<void> state = await _authRepository.withdrawal();

    // If logout failed, Guard Clause
    if (!state.success) {
      return StateWrapper<void>(
        success: state.success,
        message: state.message,
      );
    }

    await StorageFactory.systemProvider.deallocateTokens();
    await _userRepository.deleteInformation();

    return StateWrapper<void>(
      success: true,
      message: '로그아웃에 성공하였습니다.',
    );
  }
}
