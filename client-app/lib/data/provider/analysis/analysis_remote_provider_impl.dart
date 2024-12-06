import 'dart:io';

import 'package:get/get.dart';
import 'package:wooahan/app/env/common/environment_factory.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/analysis/analysis_remote_provider.dart';

class AnalysisRemoteProviderImpl extends BaseConnect
    implements AnalysisRemoteProvider {
  @override
  String get apiServerUrl => EnvironmentFactory.environment.drugServerUrl;

  @override
  Future<ResponseWrapper> postDrugBag({
    required File image,
  }) async {
    Response response = await post(
      '/api/v1/analysis/drug-bags',
      FormData({
        'image': MultipartFile(
          image,
          filename: '${DateTime.now()}.${image.path.split('.').last}',
          contentType: 'image/${image.path.split('.').last}',
        ),
      }),
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postDocument({
    required File image,
  }) async {
    Response response = await post(
      '/api/v1/analysis/documents',
      FormData({
        'image': MultipartFile(
          image,
          filename: '${DateTime.now()}.${image.path.split('.').last}',
          contentType: 'image/${image.path.split('.').last}',
        ),
      }),
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
