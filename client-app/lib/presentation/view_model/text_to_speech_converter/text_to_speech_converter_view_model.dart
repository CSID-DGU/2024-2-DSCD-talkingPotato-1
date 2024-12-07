import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/analysis/analysis_document_condition.dart';
import 'package:wooahan/domain/condition/correction/correct_document_text_condition.dart';
import 'package:wooahan/domain/usecase/anlaysis/analysis_document_use_case.dart';
import 'package:wooahan/domain/usecase/correction/correct_document_text_use_case.dart';

class TextToSpeechConverterViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final PageController pageController;

  late final AnalysisDocumentUseCase _analysisDocumentUseCase;
  late final CorrectDocumentTextUsecase _correctDocumentTextUsecase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rxn<XFile?> _image;

  late final RxBool _isViewingImage;
  late final RxBool _isListening;
  late final RxString _analysisResult;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  XFile? get image => _image.value;

  bool get isViewingImage => _isViewingImage.value;
  bool get isListening => _isListening.value;
  String get analysisResult => _analysisResult.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: 0);

    _analysisDocumentUseCase = Get.find<AnalysisDocumentUseCase>();
    _correctDocumentTextUsecase = Get.find<CorrectDocumentTextUsecase>();

    _image = Rxn<XFile?>();

    _isViewingImage = false.obs;
    _isListening = false.obs;
    _analysisResult = ''.obs;
  }

  void takePicture() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      _image.value = image;
    }
  }

  void analysisPicture() async {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    StateWrapper<String> beforeResult = await _analysisDocumentUseCase.execute(
      AnalysisDocumentCondition(file: File(_image.value!.path)),
    );

    if (beforeResult.success) {
      StateWrapper<String> afterResult =
          await _correctDocumentTextUsecase.execute(
        CorrectDocumentTextCondition(content: beforeResult.data!),
      );

      if (afterResult.success) {
        _analysisResult.value = afterResult.data!;
      }
    }

    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateViewing() {
    _isViewingImage.value = !_isViewingImage.value;
  }

  void updateListening() {
    _isListening.value = !_isListening.value;
  }
}
