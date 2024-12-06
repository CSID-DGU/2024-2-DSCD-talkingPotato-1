import 'package:get/get.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/usecase/sync_condition_usecase.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/entity/user/user_notification_time_state.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class ReadNotificationTimeInUserUseCase extends BaseUseCase
    implements SyncConditionUseCase<UserNotificationTimeState, String> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  StateWrapper<UserNotificationTimeState> execute(String condition) {
    return _userRepository.readNotificationTime(condition);
  }
}
