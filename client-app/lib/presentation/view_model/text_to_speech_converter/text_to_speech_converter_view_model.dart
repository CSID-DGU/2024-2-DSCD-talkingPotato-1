import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TextToSpeechConverterViewModel extends GetxController {
  late final PageController pageController;

  late final Rxn<XFile?> _image;
  late final RxBool _isListening;

  XFile? get image => _image.value;
  bool get isListening => _isListening.value;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(initialPage: 0);

    _image = Rxn<XFile?>();
    _isListening = false.obs;
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
    // 1. 페이지 이동
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    // 2. API 요청
    await Future.delayed(const Duration(seconds: 4));

    // 3. 페이지 이동
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateListening() {
    _isListening.value = !_isListening.value;
  }
}
