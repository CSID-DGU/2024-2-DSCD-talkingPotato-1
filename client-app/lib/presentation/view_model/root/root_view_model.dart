import 'package:get/get.dart';

class RootViewModel extends GetxController {
  late final RxInt _selectedIndex;

  int get selectedIndex => _selectedIndex.value;

  @override
  void onInit() {
    _selectedIndex = 0.obs;

    super.onInit();
  }

  void updateIndex(int index) {
    _selectedIndex.value = index;
  }
}
