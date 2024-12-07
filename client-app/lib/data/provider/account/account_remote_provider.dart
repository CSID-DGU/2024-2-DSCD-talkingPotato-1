import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class AccountRemoteProvider {
  Future<ResponseWrapper> patchPassword({required String password});
}
