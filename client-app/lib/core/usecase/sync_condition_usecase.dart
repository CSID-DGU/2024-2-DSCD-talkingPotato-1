import 'package:wooahan/core/wrapper/state_wrapper.dart';

abstract class SyncConditionUseCase<Type, Condition> {
  StateWrapper<Type> execute(Condition condition);
}
