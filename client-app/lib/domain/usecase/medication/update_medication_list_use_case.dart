import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/medication/update_medication_list_condition.dart';
import 'package:wooahan/domain/repository/medication/medication_repository.dart';

class UpdateMedicationListUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, UpdateMedicationListCondition> {
  late final MedicationRepository _medicationRepository;

  @override
  void onInit() {
    _medicationRepository = Get.find<MedicationRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpdateMedicationListCondition condition,
  ) async {
    return await _medicationRepository.updateMedicationList(condition);
  }
}
