import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_no_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';
import 'package:wooahan/domain/repository/medication/medication_repository.dart';

class ReadMedicationListUseCase extends BaseUseCase
    implements AsyncNoConditionUseCase<List<MedicationState>> {
  late final DrugRepository _drugRepository;
  late final MedicationRepository _medicationRepository;

  @override
  void onInit() {
    super.onInit();

    _drugRepository = Get.find<DrugRepository>();
    _medicationRepository = Get.find<MedicationRepository>();
  }

  @override
  Future<StateWrapper<List<MedicationState>>> execute() async {
    StateWrapper<List<MedicationState>> beforeWrapper =
        await _medicationRepository.readMedicationList();

    if (!beforeWrapper.success) {
      return StateWrapper(success: false, message: beforeWrapper.message);
    }

    List<MedicationState> afterStateList = [];

    for (MedicationState beforeState in beforeWrapper.data!) {
      StateWrapper<DrugSummaryState> afterWrapper =
          await _drugRepository.readDrugSummary(
              ReadDrugSummaryCondition(drugId: beforeState.drugId));

      if (!afterWrapper.success) {
        return StateWrapper(success: false, message: "조회 중 오류가 생겼습니다.");
      }

      afterStateList.add(beforeState.copyWith(
        drugId: afterWrapper.data!.id,
        drugName: afterWrapper.data!.name,
        drugClassificationOrManufacturer:
            afterWrapper.data!.classificationOrManufacturer,
        drugImageUrl: afterWrapper.data!.imageUrl,
        drugType: afterWrapper.data!.type,
      ));
    }

    return StateWrapper(
      success: true,
      data: afterStateList,
    );
  }
}
