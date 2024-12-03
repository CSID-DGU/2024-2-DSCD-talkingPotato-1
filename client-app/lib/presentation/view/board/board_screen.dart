import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/board/widget/article_brief_card/article_brief_card_list_view.dart';
import 'package:wooahan/presentation/view/board/widget/question_brief_card/question_brief_card_list_view.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_default_app_bar.dart';

class BoardScreen extends BaseScreen<BoardViewModel> {
  const BoardScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const TextDefaultAppBar(
      preferredSize: Size.fromHeight(64),
      title: '게시판',
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            _buildArticleHeaderView(),
            const SizedBox(height: 16),
            const ArticleBriefCardListView(),
            const SizedBox(height: 32),
            _buildQuestionHeaderView(),
            const SizedBox(height: 16),
            const QuestionBriefCardListView(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleHeaderView() {
    return Row(
      children: [
        const Text(
          '지금 많이 읽는 글',
          style: FontSystem.H4,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.ARTICLE);
          },
          child: Text(
            '더보기',
            style: FontSystem.Sub1.copyWith(
              color: ColorSystem.neutral.shade600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionHeaderView() {
    return Row(
      children: [
        const Text(
          '최근 올리온 질문',
          style: FontSystem.H4,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.QUESTION);
          },
          child: Text(
            '더보기',
            style: FontSystem.Sub1.copyWith(
              color: ColorSystem.neutral.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
