import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/user/update_notification_status_in_user_condition.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class UpdateNotificationStatusInUserUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<void, UpdateNotificationStatusInUserCondition> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpdateNotificationStatusInUserCondition condition,
  ) async {
    StateWrapper<void> state = await _userRepository.updateNotificationStatus(
      condition,
    );

    return state;
  }
}
