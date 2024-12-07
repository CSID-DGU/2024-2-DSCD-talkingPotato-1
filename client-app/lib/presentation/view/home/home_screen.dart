import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/home/widget/convert_button/convert_button.dart';
import 'package:wooahan/presentation/view/home/widget/user_information/user_information_view.dart';
import 'package:wooahan/presentation/view_model/home/home_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({super.key});

  @override
  Color get unSafeAreaColor => ColorSystem.primary;

  @override
  Color? get screenBackgroundColor => ColorSystem.neutral.shade200;

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
        height: 64,
        padding: const EdgeInsets.only(
          left: 20,
          right: 12,
          top: 16,
          bottom: 16,
        ),
        decoration: const BoxDecoration(
          color: ColorSystem.primary,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const SvgImageView(
              assetPath: 'assets/images/white_logo.svg',
              height: 32,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.SETTING);
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: const SvgImageView(
                  assetPath: 'assets/icons/setting.svg',
                  height: 32,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        const UserInformationView(),
        const SizedBox(height: 20),
        _buildButtonView(),
      ],
    );
  }

  Widget _buildButtonView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConvertButton(
          size: Size(
            (Get.width - 60) / 2,
            (Get.width - 60) / 2,
          ),
          title: '문서 읽어주기',
          content: '사진을 읽어줘요',
          assetPath: 'assets/icons/stt.svg',
          onPressed: () {
            Get.toNamed(AppRoutes.TEXT_TO_SPEECH_CONVERTER);
          },
        ),
        const SizedBox(width: 20),
        ConvertButton(
          size: Size(
            (Get.width - 60) / 2,
            (Get.width - 60) / 2,
          ),
          title: '목소리 들어주기',
          content: '말소리를 적어줘요',
          assetPath: 'assets/icons/tts.svg',
          onPressed: () {
            Get.toNamed(AppRoutes.SPEECH_TO_TEXT_CONVERTER);
          },
        ),
      ],
    );
  }
}
