import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_drug_bag_condition.dart';
import 'package:wooahan/domain/entity/drug/drug_brief_state.dart';
import 'package:wooahan/domain/entity/drug/drug_summary_state.dart';
import 'package:wooahan/domain/entity/medication/medication_state.dart';
import 'package:wooahan/domain/usecase/drug_bag/analysis_drug_bag_use_case.dart';

class MedicationAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final PageController pageController;

  late final AnalysisDrugBagUseCase _analysisDrugBagUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rxn<XFile?> _willAnalysisImage;

  late final RxBool _isAnalysing;
  late final RxString _analysingText;
  late final RxList<DrugSummaryState> _drugSummaryList;

  late final RxBool _isLoading;
  late final RxString _searchTerm;
  late final RxList<DrugBriefState> _drugBriefList;

  late final RxList<MedicationState> _medicationList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  XFile? get willAnalysisImage => _willAnalysisImage.value;

  bool get isAnalysing => _isAnalysing.value;
  String get analysingText => _analysingText.value;
  List<DrugSummaryState> get drugSummaryList => _drugSummaryList;

  bool get isLoading => _isLoading.value;
  String get searchTerm => _searchTerm.value;
  List<DrugBriefState> get drugBriefList => _drugBriefList;

  List<MedicationState> get medicationList => _medicationList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _analysisDrugBagUseCase = Get.find<AnalysisDrugBagUseCase>();

    pageController = PageController(initialPage: 0);

    _willAnalysisImage = Rxn<XFile?>();

    _isAnalysing = true.obs;
    _analysingText = "".obs;
    _drugSummaryList = <DrugSummaryState>[].obs;

    _isLoading = false.obs;
    _searchTerm = "".obs;
    _drugBriefList = <DrugBriefState>[].obs;

    _medicationList = <MedicationState>[].obs;
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
    _isAnalysing.value = true;
    _analysingText.value = "약 정보를 불러오는 중입니다.";

    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    await Future.delayed(const Duration(seconds: 2));

    await pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _isAnalysing.value = false;
  }

  void analyzeImage() async {
    _isAnalysing.value = true;
    _analysingText.value = "약 봉투를 분석 중입니다.";

    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    StateWrapper<List<DrugSummaryState>> result =
        await _analysisDrugBagUseCase.execute(
      AnalysisDrugBagCondition(
        file: File('asdf'),
      ),
    );
    print(result);

    if (result.success) {
      _drugSummaryList.assignAll(result.data!);
    }

    _isAnalysing.value = false;
  }
}
