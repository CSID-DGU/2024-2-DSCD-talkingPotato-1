import 'dart:io';

import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class LanguageAnalysisRemoteProvider {
  Future<ResponseWrapper> postAnalysisDocument({
    required File content,
  });

  Future<ResponseWrapper> postAnalysisSpeech({
    required String content,
  });
}
