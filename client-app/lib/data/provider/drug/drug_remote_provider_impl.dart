import 'package:get/get.dart';
import 'package:wooahan/app/env/common/environment_factory.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider.dart';

class DrugRemoteProviderImpl extends BaseConnect implements DrugRemoteProvider {
  @override
  String get apiServerUrl => EnvironmentFactory.environment.drugServerUrl;

  @override
  Future<ResponseWrapper> getDrugBriefList({
    required String query,
    required String page,
    required String size,
  }) async {
    Response response = await get(
      '/api/v1/drugs/briefs',
      query: {
        'query': query,
        'page': page,
        'size': size,
      },
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getDrugSummary({
    required int id,
  }) async {
    Response response = await get(
      '/api/v1/drugs/$id/summaries',
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getMedicineDetail({
    required int id,
  }) async {
    Response response = await get(
      '/api/v1/medicines/$id',
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> getVitaminDetail({
    required int id,
  }) async {
    Response response = await get(
      '/api/v1/vitamins/$id',
      headers: BaseConnect.notUseBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
