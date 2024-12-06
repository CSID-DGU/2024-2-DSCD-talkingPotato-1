import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_no_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/factory/storage_factory.dart';
import 'package:wooahan/data/provider/system/system_provider.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class FetchUserUseCase extends BaseUseCase
    implements AsyncNoConditionUseCase<void> {
  late final UserRepository _userRepository;

  @override
  void onInit() {
    super.onInit();

    _userRepository = Get.find<UserRepository>();
  }

  @override
  Future<StateWrapper<void>> execute() async {
    SystemProvider systemProvider = StorageFactory.systemProvider;

    bool success = false;

    if (systemProvider.isLogin) {
      success = await _userRepository.saveInformation();
    }

    if (!success) {
      await _userRepository.deleteInformation();
    }

    return StateWrapper(
      success: success,
      data: null,
    );
  }
}
