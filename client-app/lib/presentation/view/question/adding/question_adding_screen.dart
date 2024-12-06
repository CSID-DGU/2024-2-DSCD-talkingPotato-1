import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/question/adding/widget/question_input_field/question_input_field.dart';
import 'package:wooahan/presentation/view_model/question/adding/question_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class QuestionAddingScreen extends BaseScreen<QuestionAddingViewModel> {
  const QuestionAddingScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '질문 작성하기',
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            const SliverToBoxAdapter(
              child: QuestionInputField(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            // SliverToBoxAdapter(
            //   child: Row(
            //     children: [
            //       FilledButton(
            //         onPressed: () {},
            //         style: FilledButton.styleFrom(
            //           // Size
            //           minimumSize: const Size(200, 32),
            //           fixedSize: const Size(200, 32),
            //
            //           padding: EdgeInsets.zero,
            //
            //           // Color
            //           backgroundColor: ColorSystem.neutral.shade300,
            //           foregroundColor: ColorSystem.white,
            //
            //           disabledBackgroundColor: ColorSystem.neutral.shade300,
            //
            //           // Border
            //           shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(
            //               Radius.circular(12),
            //             ),
            //           ),
            //         ),
            //         child: Center(
            //           child: Text(
            //             "커뮤니티 이용규칙 전체 보기",
            //             style: FontSystem.H5.copyWith(
            //               color: ColorSystem.neutral,
            //               height: 1.0,
            //             ),
            //           ),
            //         ),
            //       ),
            //       const Spacer(),
            //     ],
            //   ),
            // ),
            SliverToBoxAdapter(
              child: Text(
                "우아한은 건간을 위한 커뮤니티를 만들기 위해 커뮤니티 이용규칙을 제정하여 운영하고 있습니다. 위반 시 게시물이 삭제되고 서비스 이용이 일정 기간 제한될 수 있습니다."
                "\n"
                "\n"
                "아래는 이 게시판에 해당하는 핵심 내용에 대한 요약 사항이며, 게시물 작성 전 커뮤니티 이용규칙 전문을 반드시 확인하시기 바랍니다.",
                style: FontSystem.H6.copyWith(
                  color: ColorSystem.neutral.shade600,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(height: 32),
                  Obx(() {
                    final onPressed = viewModel.content.length > 10
                        ? () {
                            viewModel.createQuestion().then((value) {
                              if (value) {
                                Get.back();
                              } else {
                                Get.snackbar('알림', '질문 작성에 실패했습니다.');
                              }
                            });
                          }
                        : null;

                    return PrimaryFillButton(
                      width: Get.width,
                      height: 60,
                      content: '완료',
                      onPressed: onPressed,
                    );
                  }),
                  SizedBox(
                    height: GetPlatform.isAndroid ? 20 : 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
