import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/medication/medication_remote_provider.dart';
import 'package:wooahan/domain/condition/medication/create_medication_list_condition.dart';
import 'package:wooahan/domain/condition/medication/update_medication_list_condition.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/domain/repository/medication/medication_repository.dart';

class MedicationRepositoryImpl extends GetxService
    implements MedicationRepository {
  late final MedicationRemoteProvider _medicationRemoteProvider;

  @override
  void onInit() {
    super.onInit();

    _medicationRemoteProvider = Get.find<MedicationRemoteProvider>();
  }

  @override
  Future<StateWrapper<List<MedicationState>>> readMedicationList() async {
    ResponseWrapper response =
        await _medicationRemoteProvider.getMedicationList();

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<MedicationState> stateList = response.data!['drugs']
        .map<MedicationState>((data) => MedicationState.fromJson(data))
        .toList();

    return StateWrapper(
      success: true,
      data: stateList,
    );
  }

  @override
  Future<StateWrapper<void>> createMedicationList(
    CreateMedicationListCondition condition,
  ) async {
    List<MedicationState> willAddMedications = condition.newMedicationList
        .where((newMedication) => !condition.existingMedicationList.any(
            (existingMedication) =>
                newMedication.drugId == existingMedication.drugId))
        .toList();

    ResponseWrapper response =
        await _medicationRemoteProvider.postMedicationList(
      medications: willAddMedications.map((e) => e.toJson()).toList(),
    );

    return StateWrapper.fromResponse(response);
  }

  @override
  Future<StateWrapper<void>> updateMedicationList(
    UpdateMedicationListCondition condition,
  ) async {
    ResponseWrapper response =
        await _medicationRemoteProvider.putMedicationList(
      medications: condition.medicationList.map((e) => e.toJson()).toList(),
    );

    return StateWrapper.fromResponse(response);
  }
}
