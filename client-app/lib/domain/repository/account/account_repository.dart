import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/account/update_password_in_account_condition.dart';

abstract class AccountRepository {
  Future<StateWrapper<void>> updatePasswordInAccount(
    UpdatePasswordInAccountCondition condition,
  );
}
