import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/sign_up/fragment/email_input_fragment.dart';
import 'package:wooahan/presentation/view_model/sign_up/sign_up_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class SignUpScreen extends BaseScreen<SignUpViewModel> {
  const SignUpScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Obx(
        () {
          return AppBar(
            // 프로그래스바
            title: viewModel.isEnableInCompletedSignUp
                ? null
                : LinearProgressIndicator(
                    value: 0.0,
                    backgroundColor: ColorSystem.neutral.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorSystem.primary.shade500,
                    ),
                  ),
            centerTitle: false,
            surfaceTintColor: ColorSystem.white,
            backgroundColor: ColorSystem.white,
            automaticallyImplyLeading: !viewModel.isEnableInCompletedSignUp,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleSpacing: 0,
            leadingWidth: 50,
            leading: viewModel.isEnableInCompletedSignUp
                ? null
                : IconButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor: ColorSystem.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    icon: SvgImageView(
                      assetPath: 'assets/icons/left_chevron.svg',
                      width: 24,
                      height: 24,
                      color: ColorSystem.neutral.shade700,
                    ),
                    onPressed: Get.back,
                  ),
          );
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          EmailInputFragment(),
          // PasswordInputFragment(),
          // NicknameInputFragment(),
          // CompletedSignUpFragment(),
        ]);
  }
}
