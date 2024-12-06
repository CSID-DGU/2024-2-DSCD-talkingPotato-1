import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/correction/correct_document_text_condition.dart';
import 'package:wooahan/domain/repository/correction/correction_repository.dart';

class CorrectDocumentTextUsecase extends BaseUseCase
    implements AsyncConditionUseCase<String, CorrectDocumentTextCondition> {
  late final CorrectionRepository _correctionRepository;

  @override
  void onInit() {
    _correctionRepository = Get.find<CorrectionRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<String>> execute(
    CorrectDocumentTextCondition condition,
  ) async {
    return await _correctionRepository.correctDocumentText(
      condition,
    );
  }
}
