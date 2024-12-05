import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';

class AnalysisDrugBagUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<DrugSummaryState>,
            AnalysisDrugBagCondition> {
  late final AnalysisRepository _analysisRepository;

  @override
  void onInit() {
    _analysisRepository = Get.find<AnalysisRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<DrugSummaryState>>> execute(
    AnalysisDrugBagCondition condition,
  ) async {
    return await _analysisRepository.analysisDrugBag(condition);
  }
}
