import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/domain/condition/auth/login_by_default_condition.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class LoginByDefaultUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, LoginByDefaultCondition> {
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _authRepository = Get.find<AuthRepository>();
    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(LoginByDefaultCondition condition) async {
    // Login Process
    StateWrapper<Map<String, dynamic>> state =
        await _authRepository.loginByDefault(condition);

    // If login failed, Guard Clause
    if (!state.success) {
      return StateWrapper<void>(
        success: state.success,
        message: state.message,
      );
    }

    await StorageFactory.systemProvider.allocateTokens(
      accessToken: state.data!['access_token'],
      refreshToken: state.data!['refresh_token'],
    );

    // User Information Cache Process
    bool result = await _userRepository.saveInformation();

    // If cache failed, Guard Clause
    if (!result) {
      await StorageFactory.systemProvider.deallocateTokens();

      return StateWrapper<void>(
        success: false,
        message: '데이터를 불러오는데 실패하였습니다. 다시 시도해주세요.',
      );
    }

    return StateWrapper<void>(
      success: true,
      message: '로그인에 성공하였습니다.',
    );
  }
}
