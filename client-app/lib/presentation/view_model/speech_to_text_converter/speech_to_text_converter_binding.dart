import 'package:get/get.dart';

import 'speech_to_text_converter_view_model.dart';

class SpeechToTextConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeechToTextConverterViewModel>(
      () => SpeechToTextConverterViewModel(),
    );
  }
}
