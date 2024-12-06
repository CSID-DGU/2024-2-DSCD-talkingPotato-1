import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_detail_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_summary_use_case.dart';
import 'package:wooahan/presentation/view_model/drug/detail/drug_detail_view_model.dart';

class DrugDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadDrugSummaryUseCase>(() => ReadDrugSummaryUseCase());
    Get.lazyPut<ReadDrugDetailUseCase>(() => ReadDrugDetailUseCase());

    Get.lazyPut<DrugDetailViewModel>(() => DrugDetailViewModel());
  }
}
