import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/presentation/view/article/detail/widget/article_detail/article_detail_view.dart';
import 'package:wooahan/presentation/view/article/detail/widget/comment_card/comment_card_list_view.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/appbar/text_back_app_bar.dart';
import 'package:wooahan/presentation/widget/common/button/primary/primary_fill_button.dart';

class ArticleDetailScreen extends GetView<ArticleDetailViewModel> {
  const ArticleDetailScreen({super.key});

  ArticleDetailViewModel get viewModel => controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildContentLayer(),
        _buildButtonLayer(),
      ],
    );
  }

  Widget _buildContentLayer() {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorSystem.white,
      appBar: TextBackAppBar(
        preferredSize: const Size.fromHeight(64),
        title: '정보 글 상세',
        onBackPress: Get.back,
      ),
      body: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ArticleDetailView(),
                const CommentCardListView(),
                SizedBox(height: GetPlatform.isAndroid ? 80 : 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonLayer() {
    return Positioned(
      right: 20,
      bottom: GetPlatform.isAndroid ? 20 : 40,
      child: PrimaryFillButton(
        width: Get.width - 40,
        height: 60,
        content: '댓글 작성하기',
        onPressed: () {
          Get.toNamed(
            AppRoutes.COMMENT_WRITING,
            arguments: {
              'type': 'article',
              'id': viewModel.articleDetail.id,
            },
          );
        },
      ),
    );
  }
}
