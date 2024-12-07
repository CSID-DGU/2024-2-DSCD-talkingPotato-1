import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/text_to_speech_converter/text_to_speech_converter_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class SelectingPictureFragment
    extends BaseScreen<TextToSpeechConverterViewModel> {
  const SelectingPictureFragment({super.key});

  @override
  Widget buildBody(BuildContext context) {
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
        '읽어줄 사진을 넣어주세요',
        style: FontSystem.H2,
      ),
      Text(
        '문서만 보일수록 더 정확하게 들을 수 있어요',
        style: FontSystem.Sub2.copyWith(
          color: ColorSystem.neutral.shade700,
        ),
      ),
    ];
  }

  Widget _buildContentView() {
    return Obx(() {
      if (viewModel.image == null) {
        return GestureDetector(
          onTap: viewModel.takePicture,
          child: Container(
            width: Get.width,
            height: Get.height * 0.4,
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
              ],
            ),
          ),
        );
      }

      return Image.file(
        File(viewModel.image!.path),
        width: Get.width,
        height: Get.height * 0.4,
        fit: BoxFit.fitHeight,
      );
    });
  }

  List<Widget> _buildButtons() {
    return [
      Obx(() {
        if (viewModel.image == null) {
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
      Obx(
        () => PrimaryFillButton(
          width: Get.width,
          height: 64,
          content: '음성으로 들려주세요',
          onPressed: viewModel.image == null ? null : viewModel.analysisPicture,
        ),
      )
    ];
  }
}
