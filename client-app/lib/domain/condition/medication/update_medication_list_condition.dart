import 'package:wooahan/domain/entity/medication/medication_state.dart';

class UpdateMedicationListCondition {
  final List<MedicationState> medicationList;

  UpdateMedicationListCondition({
    required this.medicationList,
  });
}
