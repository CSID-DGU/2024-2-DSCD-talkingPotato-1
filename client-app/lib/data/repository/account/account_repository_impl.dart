import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/account/account_remote_provider.dart';
import 'package:wooahan/domain/condition/account/update_password_in_account_condition.dart';
import 'package:wooahan/domain/repository/account/account_repository.dart';

class AccountRepositoryImpl extends GetxService implements AccountRepository {
  late final AccountRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<AccountRemoteProvider>();
  }

  @override
  Future<StateWrapper<void>> updatePasswordInAccount(
    UpdatePasswordInAccountCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.patchPassword(
      password: condition.password,
    );

    return StateWrapper.fromResponse(response);
  }
}
