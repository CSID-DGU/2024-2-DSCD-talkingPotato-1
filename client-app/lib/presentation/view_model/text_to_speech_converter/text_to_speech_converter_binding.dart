import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';

class TextToSpeechConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TextToSpeechConverterViewModel>(
      () => TextToSpeechConverterViewModel(),
    );
  }
}
