import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/medication/medication_remote_provider.dart';

class MedicationRemoteProviderImpl extends BaseConnect
    implements MedicationRemoteProvider {
  @override
  Future<ResponseWrapper> getMedicationList() async {
    Response response = await get(
      '/api/v1/medications',
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postMedicationList({
    required List<dynamic> medications,
  }) async {
    for (dynamic medication in medications) {
      await post(
        '/api/v1/medications',
        medication,
        headers: BaseConnect.useBearerToken,
      );
    }

    return ResponseWrapper.noContent();
  }

  @override
  Future<ResponseWrapper> putMedicationList({
    required List medications,
  }) async {
    Response response = await put(
      '/api/v1/medications',
      {
        'medications': medications,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
