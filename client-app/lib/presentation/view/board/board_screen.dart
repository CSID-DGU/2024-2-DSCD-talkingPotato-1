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
  Color get unSafeAreaColor => ColorSystem.white;

  @override
  Color? get screenBackgroundColor => ColorSystem.neutral.shade200;

  @override
  bool get wrapWithOuterSafeArea => true;

  @override
  bool get setTopOuterSafeArea => true;

  @override
  bool get setBottomOuterSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return const TextDefaultAppBar(
      preferredSize: Size.fromHeight(64),
      title: '게시판',
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return RefreshIndicator(
      onRefresh: viewModel.onRefresh,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildArticleView(),
                    const SizedBox(height: 16),
                    _buildQuestionHeaderView(),
                    const SizedBox(height: 80),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildArticleView() {
    return Container(
      color: ColorSystem.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '지금 많이 읽는 글',
                style: FontSystem.H3,
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
          ),
          const SizedBox(height: 16),
          const ArticleBriefCardListView(),
        ],
      ),
    );
  }

  Widget _buildQuestionHeaderView() {
    return Container(
      color: ColorSystem.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '최근 올라온 질문',
                style: FontSystem.H3,
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
          ),
          const SizedBox(height: 16),
          const QuestionBriefCardListView(),
        ],
      ),
    );
  }
}
