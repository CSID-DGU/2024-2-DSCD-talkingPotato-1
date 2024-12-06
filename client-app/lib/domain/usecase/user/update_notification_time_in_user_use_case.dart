import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/user/update_notification_time_in_user_condition.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class UpdateNotificationTimeInUserUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<void, UpdateNotificationTimeInUserCondition> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
      UpdateNotificationTimeInUserCondition condition) async {
    StateWrapper<void> state = await _userRepository.updateNotificationTime(
      condition,
    );

    return state;
  }
}
