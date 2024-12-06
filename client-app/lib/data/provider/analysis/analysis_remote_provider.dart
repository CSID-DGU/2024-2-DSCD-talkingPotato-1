import 'dart:io';

import 'package:wooahan/core/wrapper/response_wrapper.dart';

abstract class AnalysisRemoteProvider {
  Future<ResponseWrapper> postDrugBag({
    required File image,
  });

  Future<ResponseWrapper> postDocument({
    required File image,
  });
}
