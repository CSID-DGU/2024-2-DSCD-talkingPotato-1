import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/validator_util.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/change_password/change_password_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class PasswordInputFragment extends BaseScreen<ChangePasswordViewModel> {
  const PasswordInputFragment({super.key});

  @override
  Color? get screenBackgroundColor => ColorSystem.white;

  @override
  bool get wrapWithInnerSafeArea => true;

  @override
  bool get setTopInnerSafeArea => true;

  @override
  bool get setBottomInnerSafeArea => true;

  @override
  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        color: ColorSystem.white,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._buildTitleViews(),
                    const SizedBox(height: 40),
                    _buildPasswordView(),
                    const SizedBox(height: 16),
                    _buildPasswordValidationView(),
                    const Spacer(),
                    _buildNextButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTitleViews() {
    return [
      const Text(
        "비밀번호 입력",
        style: FontSystem.H1,
      ),
      Text(
        "사용할 비밀번호을 입력해주세요.",
        style: FontSystem.H5.copyWith(
          color: ColorSystem.neutral.shade600,
        ),
      ),
    ];
  }

  Widget _buildPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "비밀번호",
          style: FontSystem.Sub1.copyWith(
            color: ColorSystem.neutral,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 88,
          child: CustomInputTextField(
            placeholder: "영문, 숫자, 특수문자 포함 8자리 이상",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "비밀번호를 입력해주세요";
              } else if (!ValidatorUtil.isValidPassword(value)) {
                return "올바르지 않은 비밀번호입니다";
              }

              return null;
            },
            maxLines: 1,
            minLines: 1,
            maxLength: 20,
            textInputType: TextInputType.visiblePassword,
            hasSuffixIcon: false,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: true,
            enable: true,
            onChangedCallBack: viewModel.updateWantPassword,
            onClearCallBack: viewModel.updateWantPassword,
            onSubmittedCallBack: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordValidationView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "비밀번호 확인",
          style: FontSystem.Sub1.copyWith(
            color: ColorSystem.neutral,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 88,
          child: CustomInputTextField(
            placeholder: "영문, 숫자, 특수문자 포함 8자리 이상",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "비밀번호를 입력해주세요";
              } else if (value != viewModel.passwordInput.wantString) {
                return "비밀번호가 일치하지 않습니다";
              }

              return null;
            },
            maxLines: 1,
            minLines: 1,
            maxLength: 20,
            textInputType: TextInputType.visiblePassword,
            hasSuffixIcon: false,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: true,
            enable: true,
            onChangedCallBack: viewModel.updateValidatePassword,
            onClearCallBack: viewModel.updateValidatePassword,
            onSubmittedCallBack: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: Get.width,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Obx(() {
        Function()? onPressed = viewModel.isEnableInPasswordInput
            ? () {
                FocusManager.instance.primaryFocus?.unfocus();
                viewModel.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            : null;

        return PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: "완료",
          onPressed: onPressed,
        );
      }),
    );
  }
}
