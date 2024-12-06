import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/animation/rive_animation_view.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/drug/summary/drug_summary_default_item_view.dart';

class LoadingDrugBagAnalysisFragment
    extends BaseWidget<MedicationAddingViewModel> {
  const LoadingDrugBagAnalysisFragment({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          _buildTitleView(),
          const SizedBox(height: 32),
          _buildContentView(),
          const Spacer(),
          _buildButton(),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }

  Widget _buildTitleView() {
    return Obx(() {
      if (viewModel.isLoadingForAnalysis) {
        return const SizedBox();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '분석한 결과가 맞는지 확인해주세요',
            style: FontSystem.H2,
          ),
          Text(
            '없는 약품은 다음을 눌러 추가할 수 있어요',
            style: FontSystem.Sub2.copyWith(
              color: ColorSystem.neutral.shade700,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildContentView() {
    return Obx(() {
      if (viewModel.isLoadingForAnalysis) {
        return Column(
          children: [
            Center(
              child: SizedBox(
                height: Get.height * 0.5,
                child: const RiveAnimationView(
                  assetName: 'assets/animations/loading.riv',
                  artboardName: 'none_stop',
                  autoplay: true,
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: DefaultTextStyle(
                  style: FontSystem.H6,
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      FadeAnimatedText(
                        viewModel.loadingTextForAnalysis,
                        textAlign: TextAlign.center,
                        duration: const Duration(seconds: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewModel.drugSummaryList.length,
        itemBuilder: (context, index) {
          return DrugSummaryDefaultItemView(
            state: viewModel.drugSummaryList[index],
          );
        },
      );
    });
  }

  Widget _buildButton() {
    return Obx(() {
      if (viewModel.isLoadingForAnalysis) {
        return const SizedBox();
      }

      return PrimaryFillButton(
        width: Get.width,
        height: 64,
        content: '다음',
        onPressed: viewModel.isLoadingForAnalysis
            ? null
            : () {
                viewModel.nextPage();
              },
      );
    });
  }
}
