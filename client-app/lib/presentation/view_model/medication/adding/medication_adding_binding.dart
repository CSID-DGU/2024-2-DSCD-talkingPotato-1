import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_drug_bag_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_brief_list_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_summary_use_case.dart';
import 'package:wooahan/domain/usecase/medication/create_medication_list_use_case.dart';
import 'package:wooahan/domain/usecase/medication/read_medication_list_use_case.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';

class MedicationAddingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalysisDrugBagUseCase>(
      () => AnalysisDrugBagUseCase(),
    );
    Get.lazyPut<ReadDrugSummaryUseCase>(
      () => ReadDrugSummaryUseCase(),
    );
    Get.lazyPut<ReadDrugBriefListUseCase>(
      () => ReadDrugBriefListUseCase(),
    );
    Get.lazyPut<ReadMedicationListUseCase>(
      () => ReadMedicationListUseCase(),
    );
    Get.lazyPut<CreateMedicationListUseCase>(
      () => CreateMedicationListUseCase(),
    );

    Get.lazyPut<MedicationAddingViewModel>(
      () => MedicationAddingViewModel(),
    );
  }
}
