import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
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
  late final FlutterTts _textToSpeech;

  late final PageController pageController;

  late final AnalysisDocumentUseCase _analysisDocumentUseCase;
  late final CorrectDocumentTextUsecase _correctDocumentTextUsecase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final Rxn<XFile?> _image;

  late final RxBool _isViewingImage;
  late final RxString _analysisResult;

  late final RxBool _isFirstSpeaking;
  late final RxBool _isSpeaking;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  XFile? get image => _image.value;

  bool get isViewingImage => _isViewingImage.value;
  String get analysisResult => _analysisResult.value;

  bool get isFirstSpeaking => _isFirstSpeaking.value;
  bool get isSpeaking => _isSpeaking.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _textToSpeech = FlutterTts();

    pageController = PageController(initialPage: 0);

    _analysisDocumentUseCase = Get.find<AnalysisDocumentUseCase>();
    _correctDocumentTextUsecase = Get.find<CorrectDocumentTextUsecase>();

    _image = Rxn<XFile?>();

    _isViewingImage = false.obs;
    _analysisResult = ''.obs;

    _isFirstSpeaking = true.obs;
    _isSpeaking = false.obs;
  }

  @override
  void onReady() async {
    super.onReady();

    _textToSpeech.setLanguage("ko-KR");
    _textToSpeech.setSpeechRate(0.5);
    _textToSpeech.setVolume(0.6);
    _textToSpeech.setPitch(1);

    await _textToSpeech.setVoice(
      {
        "identifier": "com.apple.voice.compact.ko-KR.Yuna",
      },
    );
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

  void startSpeaking() {
    _isFirstSpeaking.value = false;
    _isSpeaking.value = !_isSpeaking.value;

    _textToSpeech.speak(_analysisResult.value);
  }

  void pauseSpeaking() async {
    await _textToSpeech.stop();

    _isSpeaking.value = !_isSpeaking.value;
  }
}
