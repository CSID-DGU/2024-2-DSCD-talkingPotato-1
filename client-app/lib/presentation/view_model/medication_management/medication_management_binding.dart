import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/medication_management/medication_management_view_model.dart';

class MedicationManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicationManagementViewModel>(
        () => MedicationManagementViewModel());
  }
}
