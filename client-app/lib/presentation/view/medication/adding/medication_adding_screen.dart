import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/finish_medication_fragment.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/loading_drug_bag_analysis_fragment.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/modifying_medication_fragment.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/searching_drug_fragment.dart';
import 'package:wooahan/presentation/view/medication/adding/fragment/selecting_drug_bag_picture_fragment.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

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
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorSystem.neutral.shade300,
              width: 1.0,
            ),
          ),
        ),
        child: Obx(
          () => AppBar(
            title: Text(
              '복약 추가하기',
              style: FontSystem.H3.copyWith(
                height: 1.0,
              ),
            ),
            centerTitle: false,
            surfaceTintColor: ColorSystem.white,
            backgroundColor: ColorSystem.white,
            automaticallyImplyLeading: true,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleSpacing: 0,
            leadingWidth: 50,
            leading: IconButton(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor: ColorSystem.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              icon: const SvgImageView(
                assetPath: 'assets/icons/left_chevron.svg',
                height: 20,
                color: ColorSystem.black,
              ),
              onPressed: Get.back,
            ),
            actions: [
              if (viewModel.currentPageIndex == 2)
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Get.toNamed(
                        AppRoutes.MEDICATION + AppRoutes.SHOPPING_CART_PATH,
                        arguments: {
                          'drugs': viewModel.drugSummaryList,
                        });
                  },
                ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
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
        SearchingDrugFragment(),
        ModifyingMedicationFragment(),
        FinishMedicationFragment(),
      ],
    );
  }
}
