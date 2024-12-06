import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/domain/condition/user/update_device_token_in_user_condition.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class UpdateDeviceTokenInUserUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, UpdateDeviceTokenInUserCondition> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpdateDeviceTokenInUserCondition condition,
  ) async {
    if (!StorageFactory.systemProvider.isLogin) {
      return StateWrapper(
        success: true,
      );
    }

    StateWrapper<void> state =
        await _userRepository.updateUserDeviceToken(condition);

    return state;
  }
}
