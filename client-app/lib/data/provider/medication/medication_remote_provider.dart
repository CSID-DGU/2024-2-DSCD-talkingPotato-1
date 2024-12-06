import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class MedicationRemoteProvider {
  Future<ResponseWrapper> getMedicationList();

  Future<ResponseWrapper> postMedicationList({
    required List<dynamic> medications,
  });

  Future<ResponseWrapper> putMedicationList({
    required List<dynamic> medications,
  });
}
