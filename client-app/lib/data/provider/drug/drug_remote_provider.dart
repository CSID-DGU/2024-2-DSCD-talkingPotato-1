import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class DrugRemoteProvider {
  Future<ResponseWrapper> getDrugBriefList({
    required String query,
    required String page,
    required String size,
  });

  Future<ResponseWrapper> getDrugSummary({
    required int id,
  });

  Future<ResponseWrapper> getMedicineDetail({
    required int id,
  });

  Future<ResponseWrapper> getVitaminDetail({
    required int id,
  });
}
