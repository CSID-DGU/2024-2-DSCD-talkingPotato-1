import 'package:get/get.dart';

class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;
  late final RxBool _isEnableGreyScale;

  int get selectedIndex => _selectedIndex.value;
  bool get isEnableGreyScale => _isEnableGreyScale.value;

  @override
  void onInit() {
    _selectedIndex = 0.obs;
    _isEnableGreyScale = false.obs;

    super.onInit();
  }

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }

  void updateIsEnableGreyScale() {
    _isEnableGreyScale.value = !_isEnableGreyScale.value;
  }
}
