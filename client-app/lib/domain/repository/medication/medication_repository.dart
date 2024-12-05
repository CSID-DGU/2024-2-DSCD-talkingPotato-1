import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/medication/create_medication_list_condition.dart';
import 'package:wooahan/domain/condition/medication/update_medication_list_condition.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';

abstract class MedicationRepository {
  Future<StateWrapper<List<MedicationState>>> readMedicationList();

  Future<StateWrapper<void>> createMedicationList(
    CreateMedicationListCondition condition,
  );

  Future<StateWrapper<void>> updateMedicationList(
    UpdateMedicationListCondition condition,
  );
}
