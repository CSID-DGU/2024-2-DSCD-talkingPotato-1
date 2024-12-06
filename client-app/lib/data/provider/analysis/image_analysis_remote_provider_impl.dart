import 'dart:io';

import 'package:get/get.dart';
import 'package:wooahan/app/env/common/environment_factory.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/analysis/image_analysis_remote_provider.dart';

class ImageAnalysisRemoteProviderImpl extends BaseConnect
    implements ImageAnalysisRemoteProvider {
  @override
  String get apiServerUrl => EnvironmentFactory.environment.drugServerUrl;

  @override
  Future<ResponseWrapper> postAnalysisDrugBag({
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
}
