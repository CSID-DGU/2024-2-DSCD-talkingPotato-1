import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/change_password/fragment/finish_sign_up_fragment.dart';
import 'package:wooahan/presentation/view/change_password/fragment/password_input_fragment.dart';
import 'package:wooahan/presentation/view_model/change_password/change_password_view_model.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class ChangePasswordScreen extends BaseScreen<ChangePasswordViewModel> {
  const ChangePasswordScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(56),
      child: Obx(
        () {
          return AppBar(
            centerTitle: false,
            surfaceTintColor: ColorSystem.white,
            backgroundColor: ColorSystem.white,
            automaticallyImplyLeading: !viewModel.isEnableInCompleted,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            titleSpacing: 0,
            leadingWidth: 50,
            leading: viewModel.isEnableInCompleted
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
        PasswordInputFragment(),
        FinishSignUpFragment(),
      ],
    );
  }
}
