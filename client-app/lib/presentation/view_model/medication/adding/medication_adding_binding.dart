import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';

class MedicationAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicationAddingViewModel>(() => MedicationAddingViewModel());
  }
}
