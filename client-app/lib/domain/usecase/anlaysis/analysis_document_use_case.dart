import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_document_condition.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';

class AnalysisDocumentUseCase extends BaseUseCase
    implements AsyncConditionUseCase<String, AnalysisDocumentCondition> {
  late final AnalysisRepository _analysisRepository;

  @override
  void onInit() {
    _analysisRepository = Get.find<AnalysisRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<String>> execute(
    AnalysisDocumentCondition condition,
  ) async {
    return await _analysisRepository.analysisDocument(condition);
  }
}
