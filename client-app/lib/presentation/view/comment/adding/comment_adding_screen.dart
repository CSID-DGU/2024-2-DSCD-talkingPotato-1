import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/comment/adding/widget/comment_input_field/comment_input_field.dart';
import 'package:wooahan/presentation/view/comment/adding/widget/comment_speech_button/comment_speech_button.dart';
import 'package:wooahan/presentation/view_model/comment/adding/comment_adding_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class CommentAddingScreen extends BaseScreen<CommentAddingViewModel> {
  const CommentAddingScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '댓글 작성하기',
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
              child: CommentInputField(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            const SliverToBoxAdapter(
              child: CommentSpeechButton(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            SliverToBoxAdapter(
              child: _buildRoleTextView(),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(height: 32),
                  _buildCompleteButton(),
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

  Widget _buildRoleTextView() {
    return Text(
      "우아한은 건간을 위한 커뮤니티를 만들기 위해 커뮤니티 이용규칙을 제정하여 운영하고 있습니다. 위반 시 게시물이 삭제되고 서비스 이용이 일정 기간 제한될 수 있습니다."
      "\n"
      "\n"
      "아래는 이 게시판에 해당하는 핵심 내용에 대한 요약 사항이며, 게시물 작성 전 커뮤니티 이용규칙 전문을 반드시 확인하시기 바랍니다.",
      style: FontSystem.Sub3.copyWith(
        color: ColorSystem.neutral.shade600,
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Obx(() {
      if (viewModel.speechToTextState.isListening) {
        return PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: '목소리를 받고 있어요',
          onPressed: null,
        );
      }

      if (viewModel.content.length < 10) {
        return PrimaryFillButton(
          width: Get.width,
          height: 60,
          content: '내용이 10자 미만이예요!',
          onPressed: null,
        );
      }

      final onPressed = viewModel.content.length >= 10
          ? () {
              viewModel.createComment().then((value) {
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
    });
  }
}
