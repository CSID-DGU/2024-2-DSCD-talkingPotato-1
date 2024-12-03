import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_brief_list_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';

class ReadDrugBriefListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<DrugBriefState>,
            ReadDrugBriefListCondition> {
  late final DrugRepository _drugRepository;

  @override
  void onInit() {
    _drugRepository = Get.find<DrugRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<DrugBriefState>>> execute(
    ReadDrugBriefListCondition condition,
  ) async {
    return await _drugRepository.readDrugBriefList(condition);
  }
}
