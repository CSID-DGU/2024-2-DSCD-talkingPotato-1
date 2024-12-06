import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/correction/correction_remote_provider.dart';
import 'package:wooahan/domain/condition/correction/correct_document_text_condition.dart';
import 'package:wooahan/domain/condition/correction/correct_speech_text_condition.dart';
import 'package:wooahan/domain/repository/correction/correction_repository.dart';

class CorrectionRepositoryImpl extends GetxService
    implements CorrectionRepository {
  late final CorrectionRemoteProvider _remoteProvider;

  @override
  void onInit() {
    super.onInit();

    _remoteProvider = Get.find<CorrectionRemoteProvider>();
  }

  @override
  Future<StateWrapper<String>> correctDocumentText(
    CorrectDocumentTextCondition condition,
  ) async {
    ResponseWrapper responseWrapper = await _remoteProvider.postDocumentText(
      content: condition.content,
    );

    if (responseWrapper.isFailure) {
      return StateWrapper(
        success: false,
        data: responseWrapper.message,
      );
    }

    return StateWrapper(
      success: true,
      data: responseWrapper.data!['result'],
    );
  }

  @override
  Future<StateWrapper<String>> correctSpeechText(
    CorrectSpeechTextCondition condition,
  ) async {
    ResponseWrapper responseWrapper = await _remoteProvider.postSpeechText(
      content: condition.content,
    );

    if (responseWrapper.isFailure) {
      return StateWrapper(
        success: false,
        data: responseWrapper.message,
      );
    }

    return StateWrapper(
      success: true,
      data: responseWrapper.data!['result'],
    );
  }
}
