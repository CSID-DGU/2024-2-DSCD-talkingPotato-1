import 'package:wooahan/domain/entity/medication/medication_state.dart';

class CreateMedicationListCondition {
  final List<MedicationState> medicationList;

  CreateMedicationListCondition({
    required this.medicationList,
  });
}
