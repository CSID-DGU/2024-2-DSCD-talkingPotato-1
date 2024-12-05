import 'dart:io';

import 'package:get/get.dart';
import 'package:wooahan/core/provider/base_connect.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/data/provider/analysis/language_analysis_remote_provider.dart';

class LanguageAnalysisRemoteProviderImpl extends BaseConnect
    implements LanguageAnalysisRemoteProvider {
  @override
  Future<ResponseWrapper> postAnalysisDocument({
    required File content,
  }) async {
    Response response = await post(
      '/api/v1/languages/documents',
      FormData({
        'image': MultipartFile(
          content,
          filename: '${DateTime.now()}.${content.path.split('.').last}',
          contentType: 'image/${content.path.split('.').last}',
        ),
      }),
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }

  @override
  Future<ResponseWrapper> postAnalysisSpeech({
    required String content,
  }) async {
    Response response = await post(
      '/api/v1/languages/speeches',
      {
        'content': content,
      },
      headers: BaseConnect.useBearerToken,
    );

    return ResponseWrapper.fromJson(response.body);
  }
}
