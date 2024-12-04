import 'package:get/get.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/usecase/sync_no_condition_usecase.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class ReadNicknameInUserUseCase extends BaseUseCase
    implements SyncNoConditionUseCase<String> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  StateWrapper<String> execute() {
    StateWrapper<String> result = _userRepository.readNickname();

    return result;
  }
}
