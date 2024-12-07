import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/sign_up/sign_up_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

import '../../../widget/common/text_input/custom_text_form_field.dart';

class NicknameInputFragment extends BaseScreen<SignUpViewModel> {
  const NicknameInputFragment({super.key});

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
          physics: const NeverScrollableScrollPhysics(),
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
                    _buildTitleViews(),
                    const SizedBox(height: 40),
                    _buildPasswordView(),
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

  Widget _buildTitleViews() {
    return const Text(
      "우아한에서 사용할"
      "\n"
      "닉네임을 입력해주세요",
      style: FontSystem.H1,
    );
  }

  Widget _buildPasswordView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "닉네임",
          style: FontSystem.Sub1.copyWith(
            color: ColorSystem.neutral,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 88,
          child: CustomInputTextField(
            placeholder: "1자 이상, 7자 이내(특수문자 제외)",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "닉네임을 입력해주세요.";
              } else if (!RegExp(r'^[a-zA-Z0-9가-힣]*$').hasMatch(value)) {
                return "특수문자및 초성은 사용할 수 없어요";
              }

              return null;
            },
            textInputType: TextInputType.text,
            hasSuffixIcon: false,
            maxLength: 7,
            enable: true,
            onChangedCallBack: viewModel.updateNickname,
            onClearCallBack: viewModel.updateNickname,
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
        Function()? onPressed = viewModel.isEnableInNicknameInput
            ? () {
                FocusManager.instance.primaryFocus?.unfocus();
                viewModel.createAccount().then((value) {
                  if (value.success) {
                    viewModel.pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Get.snackbar(
                      "회원가입 실패",
                      value.message!,
                    );
                  }
                });
              }
            : null;

        return PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: "다음",
          onPressed: onPressed,
        );
      }),
    );
  }
}
