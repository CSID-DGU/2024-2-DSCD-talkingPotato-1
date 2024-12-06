import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';

class ReadDrugSummaryUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<DrugSummaryState, ReadDrugSummaryCondition> {
  late final DrugRepository _drugRepository;

  @override
  void onInit() {
    _drugRepository = Get.find<DrugRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<DrugSummaryState>> execute(
    ReadDrugSummaryCondition condition,
  ) async {
    return await _drugRepository.readDrugSummary(condition);
  }
}
