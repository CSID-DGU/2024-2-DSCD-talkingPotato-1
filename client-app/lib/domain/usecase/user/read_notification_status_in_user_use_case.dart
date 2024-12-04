import 'package:get/get.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/usecase/sync_no_condition_usecase.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class ReadNotificationStatusInUserUseCase extends BaseUseCase
    implements SyncNoConditionUseCase<bool> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  StateWrapper<bool> execute() {
    StateWrapper<bool> state = _userRepository.readNotificationStatus();

    return state;
  }
}
