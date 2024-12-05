import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/medication/read_medication_list_use_case.dart';
import 'package:wooahan/domain/usecase/medication/update_medication_list_use_case.dart';
import 'package:wooahan/presentation/view_model/medication/editing/medication_editing_view_model.dart';

class MedicationEditingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadMedicationListUseCase>(
      () => ReadMedicationListUseCase(),
    );
    Get.lazyPut<UpdateMedicationListUseCase>(
      () => UpdateMedicationListUseCase(),
    );

    Get.lazyPut<MedicationEditingViewModel>(
      () => MedicationEditingViewModel(),
    );
  }
}
