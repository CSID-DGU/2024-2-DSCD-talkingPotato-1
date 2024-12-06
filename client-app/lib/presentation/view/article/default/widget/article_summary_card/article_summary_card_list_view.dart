import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/article/default/article_view_model.dart';
import 'package:wooahan/presentation/widget/article/summary/article_summary_default_item_view.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class ArticleSummaryCardListView extends BaseWidget<ArticleViewModel> {
  const ArticleSummaryCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading) {
        return const SizedBox(
          height: 120,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorSystem.primary),
            ),
          ),
        );
      }

      if (viewModel.articleSummaryList.isEmpty) {
        return SizedBox(
          height: 120,
          child: Center(
            child: Text(
              '게시글이 없습니다.',
              style: TextStyle(
                color: ColorSystem.neutral.shade600,
                fontSize: 16,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: false,
        itemCount: viewModel.articleSummaryList.length,
        separatorBuilder: (context, index) {
          return InfinityHorizonLine(
            gap: 1,
            color: ColorSystem.neutral.shade200,
          );
        },
        itemBuilder: (context, index) {
          return ArticleSummaryDefaultItemView(
            state: viewModel.articleSummaryList[index],
            onTap: () {
              Get.toNamed(
                '${AppRoutes.ARTICLE}/detail/${viewModel.articleSummaryList[index].id}',
              );
            },
          );
        },
      );
    });
  }
}
