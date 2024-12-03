import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Container(
            width: Get.width,
            height: Get.height * 0.25,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorSystem.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const TextField(
              maxLines: 10,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '댓글을 입력해주세요.',
              ),
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              // Size
              minimumSize: const Size(212, 32),
              fixedSize: const Size(212, 32),

              padding: EdgeInsets.zero,

              // Color
              backgroundColor: ColorSystem.neutral.shade300,
              foregroundColor: ColorSystem.white,

              disabledBackgroundColor: ColorSystem.neutral.shade300,

              // Border
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            child: Center(
              child: Text(
                "커뮤니티 이용규칙 전체 보기",
                style: FontSystem.H5.copyWith(
                  color: ColorSystem.neutral,
                  height: 1.0,
                ),
              ),
            ),
          ),
          Text(
            "우아한은 건간을 위한 커뮤니티를 만들기 위해 커뮤니티 이용규칙을 제정하여 운영하고 있습니다. 위반 시 게시물이 삭제되고 서비스 이용이 일정 기간 제한될 수 있습니다."
            "\n"
            "\n"
            "아래는 이 게시판에 해당하는 핵심 내용에 대한 요약 사항이며, 게시물 작성 전 커뮤니티 이용규칙 전문을 반드시 확인하시기 바랍니다.",
            style: FontSystem.H6.copyWith(
              color: ColorSystem.neutral.shade600,
            ),
          ),
          const Spacer(),
          PrimaryFillButton(
            width: Get.width,
            height: 60,
            content: '완료',
            onPressed: Get.back,
          ),
          SizedBox(height: GetPlatform.isAndroid ? 20 : 40),
        ],
      ),
    );
  }
}
