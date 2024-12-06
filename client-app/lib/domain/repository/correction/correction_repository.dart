import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/correction/correct_document_text_condition.dart';
import 'package:wooahan/domain/condition/correction/correct_speech_text_condition.dart';

abstract class CorrectionRepository {
  Future<StateWrapper<String>> correctDocumentText(
    CorrectDocumentTextCondition condition,
  );

  Future<StateWrapper<String>> correctSpeechText(
    CorrectSpeechTextCondition condition,
  );
}
