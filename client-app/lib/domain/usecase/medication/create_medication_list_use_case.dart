import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/medication/create_medication_list_condition.dart';
import 'package:wooahan/domain/repository/medication/medication_repository.dart';

class CreateMedicationListUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, CreateMedicationListCondition> {
  late final MedicationRepository _medicationRepository;

  @override
  void onInit() {
    _medicationRepository = Get.find<MedicationRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<void>> execute(
    CreateMedicationListCondition condition,
  ) async {
    return await _medicationRepository.createMedicationList(condition);
  }
}
