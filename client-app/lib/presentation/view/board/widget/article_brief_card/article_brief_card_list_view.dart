import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/article/brief/article_brief_default_item_view.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class ArticleBriefCardListView extends BaseWidget<BoardViewModel> {
  const ArticleBriefCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(() {
      if (viewModel.isLoading) {
        return const SizedBox(
          height: 321,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(ColorSystem.primary),
            ),
          ),
        );
      }

      if (viewModel.articleBriefList.isEmpty) {
        return SizedBox(
          height: 160,
          child: Center(
            child: Text(
              '게시글이 없습니다.',
              style: FontSystem.H5.copyWith(
                color: ColorSystem.neutral.shade600,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: viewModel.articleBriefList.length,
        separatorBuilder: (context, index) {
          return InfinityHorizonLine(
            gap: 1,
            color: ColorSystem.neutral.shade200,
          );
        },
        itemBuilder: (context, index) {
          return ArticleBriefDefaultItemView(
            state: viewModel.articleBriefList[index],
            onTap: () {
              Get.toNamed(
                '${AppRoutes.ARTICLE}/detail/${viewModel.articleBriefList[index].id}',
              );
            },
          );
        },
      );
    });
  }
}
