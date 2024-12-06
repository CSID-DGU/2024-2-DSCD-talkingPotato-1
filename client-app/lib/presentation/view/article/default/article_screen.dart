import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_screen.dart';
import 'package:wooahan/presentation/view/article/default/widget/article_summary_card/article_summary_card_list_view.dart';
import 'package:wooahan/presentation/view_model/article/default/article_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';

class ArticleScreen extends BaseScreen<ArticleViewModel> {
  const ArticleScreen({super.key});

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return TextBackAppBar(
      preferredSize: const Size.fromHeight(64),
      title: '정보 글 목록',
      actions: [
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.ARTICLE + AppRoutes.SEARCHING_PATH);
          },
          icon: const Icon(
            Icons.search,
            size: 32,
            color: ColorSystem.black,
          ),
        ),
        const SizedBox(width: 8),
      ],
      onBackPress: Get.back,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RefreshIndicator(
        onRefresh: viewModel.onRefresh,
        child: const ArticleSummaryCardListView(),
      ),
    );
  }
}
