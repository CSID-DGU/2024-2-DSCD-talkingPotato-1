import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_document_use_case.dart';
import 'package:wooahan/domain/usecase/correction/correct_document_text_use_case.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';

class TextToSpeechConverterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisDocumentUseCase>(
      () => AnalysisDocumentUseCase(),
    );
    Get.lazyPut<CorrectDocumentTextUsecase>(
      () => CorrectDocumentTextUsecase(),
    );

    Get.lazyPut<TextToSpeechConverterViewModel>(
      () => TextToSpeechConverterViewModel(),
    );
  }
}
