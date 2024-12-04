import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/loading_drug_bag_analysis_fragment.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/selecting_drug_bag_picture_fragment.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class MedicationAddingScreen extends BaseScreen<MedicationAddingViewModel> {
  const MedicationAddingScreen({super.key});

  @override
  Color get unSafeAreaColor => ColorSystem.white;

  @override
  Color? get screenBackgroundColor => ColorSystem.white;

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get setTopOuterSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      title: '복약 추가하기',
      backgroundColor: ColorSystem.white,
      onBackPress: Get.back,
      preferredSize: const Size.fromHeight(64),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: viewModel.pageController,
      children: const [
        SelectingDrugBagPictureFragment(),
        LoadingDrugBagAnalysisFragment(),
      ],
    );
  }
}
