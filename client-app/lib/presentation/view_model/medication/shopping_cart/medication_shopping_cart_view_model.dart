import 'package:get/get.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';

class MedicationShoppingCartViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final List<DrugSummaryState> drugSummaryList;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    drugSummaryList = Get.arguments['drugs'] as List<DrugSummaryState>;
  }
}
