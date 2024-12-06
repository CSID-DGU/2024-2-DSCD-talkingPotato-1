import 'package:wooahan/domain/entity/medication/medication_state.dart';

class CreateMedicationListCondition {
  final List<MedicationState> existingMedicationList;
  final List<MedicationState> newMedicationList;

  CreateMedicationListCondition({
    required this.existingMedicationList,
    required this.newMedicationList,
  });
}
