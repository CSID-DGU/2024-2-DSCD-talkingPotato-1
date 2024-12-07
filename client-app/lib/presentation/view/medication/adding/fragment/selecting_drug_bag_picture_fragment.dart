import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/medication/adding/medication_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class SelectingDrugBagPictureFragment
    extends BaseWidget<MedicationAddingViewModel> {
  const SelectingDrugBagPictureFragment({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          ..._buildTitleViews(),
          const Spacer(),
          _buildContentView(),
          const Spacer(),
          ..._buildButtons(),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }

  List<Widget> _buildTitleViews() {
    return [
      const Text(
        '등록할 약봉투를 넣어주세요',
        style: FontSystem.H2,
      ),
      Text(
        '약봉투의 약 목록만 보일수록 정확도가 올라가요',
        style: FontSystem.Sub2.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
      ),
    ];
  }

  Widget _buildContentView() {
    return Obx(() {
      if (viewModel.willAnalysisImage == null) {
        return GestureDetector(
          onTap: viewModel.takePicture,
          child: Container(
            width: Get.width,
            height: Get.height * 0.45,
            color: ColorSystem.neutral.shade100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgImageView(
                  assetPath: 'assets/icons/picture.svg',
                  height: Get.height * 0.2,
                ),
                const SizedBox(height: 8),
                Text(
                  '사진 모양을 누를 시 사진을 찍을 수 있어요',
                  style: FontSystem.Sub2.copyWith(
                    color: ColorSystem.neutral,
                  ),
                ),
                Text(
                  '사진을 추가하지 않고 싶으면 다음을 눌러주세요',
                  style: FontSystem.Sub2.copyWith(
                    color: ColorSystem.neutral,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Image.file(
        File(viewModel.willAnalysisImage!.path),
        width: Get.width,
        height: Get.height * 0.45,
        fit: BoxFit.fitHeight,
      );
    });
  }

  List<Widget> _buildButtons() {
    return [
      Obx(() {
        if (viewModel.willAnalysisImage == null) {
          return const SizedBox(height: 64);
        }

        return PrimaryFillButton(
          width: Get.width,
          height: 64,
          content: '다시 찍을래요',
          onPressed: viewModel.takePicture,
        );
      }),
      const SizedBox(height: 20),
      PrimaryFillButton(
        width: Get.width,
        height: 64,
        content: '다음',
        onPressed: () {
          if (viewModel.willAnalysisImage == null) {
            viewModel.loadDrugList();
          } else {
            viewModel.analyzeImage();
          }
        },
      ),
    ];
  }
}
