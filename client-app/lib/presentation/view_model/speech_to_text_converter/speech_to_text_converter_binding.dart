import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/correction/correct_speech_text_use_case.dart';

import 'speech_to_text_converter_view_model.dart';

class SpeechToTextConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CorrectSpeechTextUseCase>(
      () => CorrectSpeechTextUseCase(),
    );

    Get.lazyPut<SpeechToTextConverterViewModel>(
      () => SpeechToTextConverterViewModel(),
    );
  }
}
