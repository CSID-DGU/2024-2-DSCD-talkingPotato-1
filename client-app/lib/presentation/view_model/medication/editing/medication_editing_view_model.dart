import 'dart:async';

import 'package:get/get.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/medication/update_medication_list_condition.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/domain/usecase/medication/read_medication_list_use_case.dart';
import 'package:wooahan/domain/usecase/medication/update_medication_list_use_case.dart';

class MedicationEditingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadMedicationListUseCase _readMedicationListUseCase;
  late final UpdateMedicationListUseCase _updateMedicationListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final RxBool _isEdited;
  late final RxInt _currentIndex;

  late final List<MedicationState> _originalMedicationList;
  late final RxList<MedicationState> _modifiedMedicationList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isInitLoading => _isInitLoading.value;
  bool get isEdited => _isEdited.value;
  int get currentIndex => _currentIndex.value;

  List<MedicationState> get modifiedMedicationList => _modifiedMedicationList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readMedicationListUseCase = Get.find<ReadMedicationListUseCase>();
    _updateMedicationListUseCase = Get.find<UpdateMedicationListUseCase>();

    _isInitLoading = true.obs;
    _isEdited = false.obs;
    _currentIndex = 0.obs;

    _modifiedMedicationList = <MedicationState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    await Future.wait([
      _fetchMedicationList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> _fetchMedicationList() async {
    StateWrapper<List<MedicationState>> stateWrapper =
        await _readMedicationListUseCase.execute();

    if (!stateWrapper.success) {
      return;
    }

    _originalMedicationList = stateWrapper.data!;
    _modifiedMedicationList.assignAll(stateWrapper.data!);
  }

  void incrementCurrentIndex() {
    _currentIndex.value++;
  }

  void decrementCurrentIndex() {
    _currentIndex.value--;
  }

  void updateIsTakenInMedication(
    int index,
    String timeline,
  ) {
    switch (timeline) {
      case 'breakfast':
        bool nextIsTaken = !_modifiedMedicationList[index].isTakenInBreakfast;

        bool isTakenInDaily = !nextIsTaken &&
            !_modifiedMedicationList[index].isTakenInLunch &&
            !_modifiedMedicationList[index].isTakenInDinner;

        _modifiedMedicationList[index] =
            _modifiedMedicationList[index].copyWith(
          isTakenInBreakfast:
              !_modifiedMedicationList[index].isTakenInBreakfast,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'lunch':
        bool nextIsTaken = !_modifiedMedicationList[index].isTakenInLunch;

        bool isTakenInDaily = !nextIsTaken &&
            !_modifiedMedicationList[index].isTakenInBreakfast &&
            !_modifiedMedicationList[index].isTakenInDinner;

        _modifiedMedicationList[index] =
            _modifiedMedicationList[index].copyWith(
          isTakenInLunch: !_modifiedMedicationList[index].isTakenInLunch,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'dinner':
        bool nextIsTaken = !_modifiedMedicationList[index].isTakenInDinner;

        bool isTakenInDaily = !nextIsTaken &&
            !_modifiedMedicationList[index].isTakenInBreakfast &&
            !_modifiedMedicationList[index].isTakenInLunch;

        _modifiedMedicationList[index] =
            _modifiedMedicationList[index].copyWith(
          isTakenInDinner: !_modifiedMedicationList[index].isTakenInDinner,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'daily':
        bool nextIsTaken = !_modifiedMedicationList[index].isTakenInDaily;

        _modifiedMedicationList[index] =
            _modifiedMedicationList[index].copyWith(
          isTakenInBreakfast: !nextIsTaken,
          isTakenInLunch: !nextIsTaken,
          isTakenInDinner: !nextIsTaken,
          isTakenInDaily: nextIsTaken,
        );
        break;
    }

    _isEdited.value = !_equalsMedicationList();
  }

  void removeMedication(int index) {
    _modifiedMedicationList.removeAt(index);

    if (index == _modifiedMedicationList.length) {
      _currentIndex.value--;
    }

    _isEdited.value = !_equalsMedicationList();
  }

  Future<bool> deleteAllApply() async {
    StateWrapper<void> stateWrapper =
        await _updateMedicationListUseCase.execute(
      UpdateMedicationListCondition(
        medicationList: [],
      ),
    );

    if (!stateWrapper.success) {
      return false;
    }

    _modifiedMedicationList.clear();
    _currentIndex.value = 0;

    await Get.find<BaseMediator>().publishUpdateMedicationEvent();

    return true;
  }

  Future<bool> confirmApply() async {
    StateWrapper<void> stateWrapper =
        await _updateMedicationListUseCase.execute(
      UpdateMedicationListCondition(
        medicationList: _modifiedMedicationList,
      ),
    );

    if (!stateWrapper.success) {
      return false;
    }

    await Get.find<BaseMediator>().publishUpdateMedicationEvent();

    return true;
  }

  bool _equalsMedicationList() {
    if (_originalMedicationList.length != _modifiedMedicationList.length) {
      return false;
    }

    for (int i = 0; i < _originalMedicationList.length; i++) {
      if (_originalMedicationList[i] != _modifiedMedicationList[i]) {
        return false;
      }
    }

    return true;
  }
}
