import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/account/account_remote_provider.dart';

class AccountRemoteProviderImpl extends BaseConnect
    implements AccountRemoteProvider {
  @override
  Future<ResponseWrapper> patchPassword({
    required String password,
  }) async {
    final response = await patch(
      '/api/v1/accounts/password',
      {
        'password': password,
      },
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
