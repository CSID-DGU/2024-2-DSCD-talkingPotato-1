import 'package:get/get.dart';
import 'package:wooahan/presentation/view_model/medication/shopping_cart/medication_shopping_cart_view_model.dart';

class MedicationShoppingCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicationShoppingCartViewModel>(
      () => MedicationShoppingCartViewModel(),
    );
  }
}
