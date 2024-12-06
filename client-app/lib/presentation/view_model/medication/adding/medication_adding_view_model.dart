import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_brief_list_condition.dart';
import 'package:wooahan/domain/condition/drug/read_drug_summary_condition.dart';
import 'package:wooahan/domain/condition/medication/create_medication_list_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_drug_bag_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_brief_list_use_case.dart';
import 'package:wooahan/domain/usecase/drug/read_drug_summary_use_case.dart';
import 'package:wooahan/domain/usecase/medication/create_medication_list_use_case.dart';
import 'package:wooahan/domain/usecase/medication/read_medication_list_use_case.dart';

class MedicationAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final FocusNode focusNode;
  late final PageController pageController;

  late final AnalysisDrugBagUseCase _analysisDrugBagUseCase;
  late final ReadDrugSummaryUseCase _readDrugSummaryUseCase;
  late final ReadDrugBriefListUseCase _readDrugBriefListUseCase;
  late final ReadMedicationListUseCase _readMedicationListUseCase;
  late final CreateMedicationListUseCase _createMedicationListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxInt _currentPageIndex;
  late final Rxn<XFile?> _willAnalysisImage;

  late final RxBool _isLoadingForAnalysis;
  late final RxString _loadingTextForAnalysis;
  late final RxList<DrugSummaryState> _drugSummaryList;

  late final RxBool _isLoadingSearching;
  late final RxBool _isFocusedSearchTermField;
  late final RxString _searchTerm;
  late final RxList<DrugBriefState> _drugBriefList;

  late final RxInt _currentMedicationIndex;
  late final RxList<MedicationState> _existingMedicationList;
  late final RxList<MedicationState> _newMedicationList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  int get currentPageIndex => _currentPageIndex.value;
  XFile? get willAnalysisImage => _willAnalysisImage.value;

  bool get isLoadingForAnalysis => _isLoadingForAnalysis.value;
  String get loadingTextForAnalysis => _loadingTextForAnalysis.value;
  List<DrugSummaryState> get drugSummaryList => _drugSummaryList;

  bool get isFocusedSearchTermField => _isFocusedSearchTermField.value;
  bool get isLoadingSearching => _isLoadingSearching.value;
  String get searchTerm => _searchTerm.value;
  List<DrugBriefState> get drugBriefList => _drugBriefList;

  int get currentMedicationIndex => _currentMedicationIndex.value;
  List<MedicationState> get existingMedicationList => _existingMedicationList;
  List<MedicationState> get newMedicationList => _newMedicationList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    focusNode = FocusNode();
    pageController = PageController(initialPage: 0);

    _analysisDrugBagUseCase = Get.find<AnalysisDrugBagUseCase>();
    _readDrugSummaryUseCase = Get.find<ReadDrugSummaryUseCase>();
    _readDrugBriefListUseCase = Get.find<ReadDrugBriefListUseCase>();
    _readMedicationListUseCase = Get.find<ReadMedicationListUseCase>();
    _createMedicationListUseCase = Get.find<CreateMedicationListUseCase>();

    _currentPageIndex = 0.obs;
    _willAnalysisImage = Rxn<XFile?>();

    _isLoadingForAnalysis = true.obs;
    _loadingTextForAnalysis = "".obs;
    _drugSummaryList = <DrugSummaryState>[].obs;

    _isLoadingSearching = false.obs;
    _isFocusedSearchTermField = false.obs;
    _searchTerm = "".obs;
    _drugBriefList = <DrugBriefState>[].obs;

    _currentMedicationIndex = 0.obs;
    _existingMedicationList = <MedicationState>[].obs;
    _newMedicationList = <MedicationState>[].obs;
  }

  @override
  void onReady() {
    super.onReady();

    _fetchExistingMedicationList();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _isFocusedSearchTermField.value = true;
      } else {
        _isFocusedSearchTermField.value = false;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();

    focusNode.dispose();
    pageController.dispose();
  }

  void _fetchExistingMedicationList() async {
    StateWrapper<List<MedicationState>> result =
        await _readMedicationListUseCase.execute();

    if (result.success) {
      _existingMedicationList.assignAll(result.data!);
    }
  }

  Future<void> nextPage() async {
    _currentPageIndex.value++;

    await pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      _willAnalysisImage.value = image;
    }
  }

  void loadDrugList() async {
    _isLoadingForAnalysis.value = true;
    _loadingTextForAnalysis.value = "약 정보를 불러오는 중입니다.";

    nextPage();

    await Future.delayed(const Duration(seconds: 2));

    await nextPage();

    _isLoadingForAnalysis.value = false;
  }

  void analyzeImage() async {
    _isLoadingForAnalysis.value = true;
    _loadingTextForAnalysis.value = "약 봉투를 분석 중입니다.";

    nextPage();

    StateWrapper<List<DrugSummaryState>> result =
        await _analysisDrugBagUseCase.execute(
      AnalysisDrugBagCondition(
        file: File(_willAnalysisImage.value!.path),
      ),
    );

    if (result.success) {
      _drugSummaryList.assignAll(result.data!);
    }

    _isLoadingForAnalysis.value = false;
  }

  void updateSearchTerm(String term) {
    if (term.isEmpty && _isFocusedSearchTermField.isFalse) {
      _drugBriefList.clear();
    }

    _searchTerm.value = term;
  }

  void updateDrugBriefList() async {
    _isLoadingSearching.value = true;

    StateWrapper<List<DrugBriefState>> result =
        await _readDrugBriefListUseCase.execute(
      ReadDrugBriefListCondition(
        searchTerm: searchTerm,
        page: 1,
        size: 50,
      ),
    );

    if (result.success) {
      _drugBriefList.assignAll(result.data!);
    }

    _isLoadingSearching.value = false;
  }

  Future<bool> addDrugSummary(int index) async {
    DrugBriefState state = _drugBriefList[index];

    if (_drugSummaryList.any((element) => element.id == state.id)) {
      return false;
    }

    StateWrapper<DrugSummaryState> stateWrapper =
        await _readDrugSummaryUseCase.execute(
      ReadDrugSummaryCondition(
        drugId: state.id,
      ),
    );

    if (stateWrapper.success) {
      _drugSummaryList.add(stateWrapper.data!);

      return true;
    }

    return false;
  }

  void convertDrugSummaryToMedication() {
    _newMedicationList.assignAll(
      _drugSummaryList.map(
        (e) => MedicationState(
          drugId: e.id,
          drugName: e.name,
          drugImageUrl: e.imageUrl,
          drugClassificationOrManufacturer: e.classificationOrManufacturer,
          drugType: e.type,
          isTakenInBreakfast: true,
          isTakenInLunch: true,
          isTakenInDinner: true,
          isTakenInDaily: false,
        ),
      ),
    );
  }

  void incrementCurrentIndex() {
    _currentMedicationIndex.value++;
  }

  void decrementCurrentIndex() {
    _currentMedicationIndex.value--;
  }

  void updateIsTakenInMedication(
    int index,
    String timeline,
  ) {
    switch (timeline) {
      case 'breakfast':
        bool nextIsTaken = !_newMedicationList[index].isTakenInBreakfast;

        bool isTakenInDaily = !nextIsTaken &&
            !_newMedicationList[index].isTakenInLunch &&
            !_newMedicationList[index].isTakenInDinner;

        _newMedicationList[index] = _newMedicationList[index].copyWith(
          isTakenInBreakfast: !_newMedicationList[index].isTakenInBreakfast,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'lunch':
        bool nextIsTaken = !_newMedicationList[index].isTakenInLunch;

        bool isTakenInDaily = !nextIsTaken &&
            !_newMedicationList[index].isTakenInBreakfast &&
            !_newMedicationList[index].isTakenInDinner;

        _newMedicationList[index] = _newMedicationList[index].copyWith(
          isTakenInLunch: !_newMedicationList[index].isTakenInLunch,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'dinner':
        bool nextIsTaken = !_newMedicationList[index].isTakenInDinner;

        bool isTakenInDaily = !nextIsTaken &&
            !_newMedicationList[index].isTakenInBreakfast &&
            !_newMedicationList[index].isTakenInLunch;

        _newMedicationList[index] = _newMedicationList[index].copyWith(
          isTakenInDinner: !_newMedicationList[index].isTakenInDinner,
          isTakenInDaily: isTakenInDaily,
        );
        break;
      case 'daily':
        bool nextIsTaken = !_newMedicationList[index].isTakenInDaily;

        _newMedicationList[index] = _newMedicationList[index].copyWith(
          isTakenInBreakfast: !nextIsTaken,
          isTakenInLunch: !nextIsTaken,
          isTakenInDinner: !nextIsTaken,
          isTakenInDaily: nextIsTaken,
        );
        break;
    }
  }

  void removeMedication(int index) {
    _newMedicationList.removeAt(index);

    if (index == _newMedicationList.length) {
      _currentMedicationIndex.value--;
    }
  }

  Future<bool> confirmApply() async {
    StateWrapper<void> result = await _createMedicationListUseCase.execute(
      CreateMedicationListCondition(
        existingMedicationList: _existingMedicationList,
        newMedicationList: _newMedicationList,
      ),
    );

    if (result.success) {
      Get.find<BaseMediator>().publishUpdateMedicationEvent();
    }

    return result.success;
  }
}
