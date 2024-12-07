import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/login/login_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({super.key});

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setTopInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  _buildLogoView(),
                  const Spacer(),
                  const SizedBox(height: 32),
                  ..._buildEmailViews(),
                  const SizedBox(height: 12),
                  ..._buildPasswordViews(),
                  const Spacer(),
                  _buildSignUpTextView(),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoView() {
    return Center(
      child: SizedBox(
        height: Get.height * 0.08,
        child: const SvgImageView(
          assetPath: 'assets/images/black_logo.svg',
        ),
      ),
    );
  }

  List<Widget> _buildEmailViews() {
    return [
      Text(
        "이메일",
        style: FontSystem.Sub1.copyWith(
          color: ColorSystem.neutral,
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        height: 84,
        child: Obx(
          () => CustomInputTextField(
            placeholder: "이메일을 입력해주세요",
            validator: (value) {
              return null;
            },
            textInputType: TextInputType.emailAddress,
            hasSuffixIcon: viewModel.emailStr.isNotEmpty,
            enable: !viewModel.isLoadingByLogin,
            onChangedCallBack: viewModel.updateEmail,
            onClearCallBack: viewModel.updateEmail,
            onSubmittedCallBack: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildPasswordViews() {
    return [
      Text(
        "비밀번호",
        style: FontSystem.Sub1.copyWith(
          color: ColorSystem.neutral,
        ),
      ),
      const SizedBox(height: 4),
      SizedBox(
        height: 84,
        child: Obx(
          () => CustomInputTextField(
            placeholder: "비밀번호을 입력해주세요",
            validator: (value) {
              return null;
            },
            maxLines: 1,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            hasSuffixIcon: viewModel.passwordStr.isNotEmpty,
            enable: !viewModel.isLoadingByLogin,
            onChangedCallBack: viewModel.updatePassword,
            onClearCallBack: viewModel.updatePassword,
            onSubmittedCallBack: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      )
    ];
  }

  Widget _buildSignUpTextView() {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.SIGN_UP);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            children: [
              Text(
                "아직 계정이 없으신가요?",
                style: FontSystem.Sub2.copyWith(
                  color: ColorSystem.neutral,
                ),
              ),
              SizedBox(
                width: 168,
                child: InfinityHorizonLine(
                  gap: 1,
                  color: ColorSystem.neutral.shade300,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 60,
      width: Get.width,
      child: Obx(
        () => PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: '로그인',
          onPressed: viewModel.isEnableLoginButton
              ? () {
                  viewModel.login().then((value) {
                    if (value.success) {
                      Get.offAndToNamed(AppRoutes.ROOT);
                    } else {
                      Get.snackbar("로그인 실패", value.message!);
                    }
                  });
                }
              : null,
        ),
      ),
    );
  }
}
