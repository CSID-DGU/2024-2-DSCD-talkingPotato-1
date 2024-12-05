import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_speech_use_case.dart';

import 'speech_to_text_converter_view_model.dart';

class SpeechToTextConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisSpeechUseCase>(
      () => AnalysisSpeechUseCase(),
    );

    Get.lazyPut<SpeechToTextConverterViewModel>(
      () => SpeechToTextConverterViewModel(),
    );
  }
}
