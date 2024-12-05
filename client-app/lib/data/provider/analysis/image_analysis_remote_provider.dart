import 'dart:io';

import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class ImageAnalysisRemoteProvider {
  Future<ResponseWrapper> postAnalysisDrugBag({
    required File image,
  });
}
