import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/validator_util.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view_model/sign_up/sign_up_view_model.dart';
import 'package:wooahan/presentation/widget/common/button/neutral/neutral_fill_button.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';
import 'package:wooahan/presentation/widget/common/text_input/custom_text_form_field.dart';

class EmailInputFragment extends BaseScreen<SignUpViewModel> {
  const EmailInputFragment({super.key});

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
                    _buildEmailView(),
                    const SizedBox(height: 16),
                    _buildAuthenticationCodeView(),
                    _buildValidationButton(),
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
        "이메일 입력",
        style: FontSystem.H1,
      ),
      Text(
        "사용할 이메일을 입력해주세요.",
        style: FontSystem.H5.copyWith(
          color: ColorSystem.neutral.shade600,
        ),
      ),
    ];
  }

  Widget _buildEmailView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "이메일",
          style: FontSystem.Sub1.copyWith(
            color: ColorSystem.neutral,
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 88,
          child: Obx(
            () {
              return CustomInputTextField(
                placeholder: "이메일을 입력해주세요",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "이메일을 입력해주세요";
                  } else if (!ValidatorUtil.isValidEmail(value)) {
                    return "이메일 형식이 올바르지 않습니다";
                  }

                  return null;
                },
                textInputType: TextInputType.emailAddress,
                hasSuffixIcon: false,
                enable: viewModel.emailInput.isEnabledSerialEmail,
                onChangedCallBack: viewModel.updateEmail,
                onClearCallBack: viewModel.updateEmail,
                onSubmittedCallBack: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAuthenticationCodeView() {
    return Obx(
      () {
        if (viewModel.emailInput.status == EmailInputState.INVALID_EMAIL ||
            viewModel.emailInput.status == EmailInputState.VALID_EMAIL) {
          return const SizedBox();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "인증번호",
              style: FontSystem.Sub1.copyWith(
                color: ColorSystem.neutral,
              ),
            ),
            const SizedBox(height: 4),
            Obx(() {
              return SizedBox(
                height: 88,
                child: CustomInputTextField(
                  maxLength: 6,
                  placeholder: "인증번호을 입력해주세요",
                  textInputType: TextInputType.number,
                  hasSuffixIcon: false,
                  enable: viewModel.emailInput.isEnabledAuthenticationCode,
                  textInputAction: TextInputAction.done,
                  onChangedCallBack: viewModel.updateAuthenticationCode,
                  onClearCallBack: viewModel.updateAuthenticationCode,
                  onSubmittedCallBack: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              );
            }),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildValidationButton() {
    return Center(
      child: SizedBox(
        width: 180,
        height: 60,
        child: Obx(
          () {
            String content = viewModel.emailInput.statusTitle;

            Function()? onPressed;

            if (viewModel.emailInput.status == EmailInputState.VALID_EMAIL) {
              onPressed = () async {
                viewModel.validateSerialEmail().then((value) {
                  if (value.success) {
                    Get.snackbar(
                      "인증번호 전송",
                      "인증번호가 전송되었습니다.",
                    );
                  } else {
                    Get.snackbar(
                      "인증번호 전송 실패",
                      value.message!,
                    );
                  }
                });
              };
            } else if (viewModel.emailInput.status ==
                EmailInputState.VALID_AUTHENTICATION_CODE) {
              onPressed = () {
                viewModel.validateAuthenticationCode().then((value) {
                  if (value.success) {
                    Get.snackbar(
                      "인증 성공",
                      "인증이 완료되었습니다.",
                    );
                  } else {
                    Get.snackbar(
                      "인증 실패",
                      value.message!,
                    );
                  }
                });
              };
            } else {
              onPressed = null;
            }

            return NeutralFillButton(
              width: 180,
              height: 60,
              content: content,
              onPressed: onPressed,
            );
          },
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: Get.width,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      child: Obx(() {
        Function()? onPressed = viewModel.isEnableInEmailInput
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
          content: "다음",
          onPressed: onPressed,
        );
      }),
    );
  }
}
