import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/presentation/view_model/splash/splash_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/secondary/secondary_fill_button.dart';

class SplashScreen extends GetView<SplashViewModel> {
  const SplashScreen({super.key});

  SplashViewModel get viewModel => Get.find<SplashViewModel>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContentLayer(),
        _buildButtonLayer(),
      ],
    );
  }

  Widget _buildContentLayer() {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorSystem.white,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 84),
              Image.asset(
                'assets/images/white_icon.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 40),
              Obx(
                () => Text(
                  viewModel.informationText,
                  style: FontSystem.H6.copyWith(
                    color: ColorSystem.black,
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLayer() {
    return Obx(
      () {
        if (viewModel.isConnectedToInternet) {
          return const SizedBox();
        }

        return Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.7,
            child: SizedBox(
              height: 60,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SecondaryFillButton(
                  width: Get.width - 40,
                  height: 60,
                  content: "연결 다시하기",
                  onPressed: viewModel.checkDevice,
                ),
              ),
            ),
          ),
        ).paddingOnly(
          bottom: GetPlatform.isAndroid ? 20 : 40,
        );
      },
    );
  }
}
