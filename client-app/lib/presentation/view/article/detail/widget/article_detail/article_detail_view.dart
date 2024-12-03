import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class ArticleDetailView extends BaseWidget<ArticleDetailViewModel> {
  const ArticleDetailView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Obx(
            () => Wrap(
              children: [
                for (final tag in viewModel.articleDetail.tags)
                  Container(
                    margin: const EdgeInsets.only(right: 4),
                    child: Text(
                      "#$tag",
                      style: FontSystem.H5.copyWith(
                        color: ColorSystem.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              viewModel.articleDetail.title,
              style: FontSystem.H1,
            ),
          ),
          const SizedBox(height: 32),
          Container(
            constraints: BoxConstraints(
              minHeight: 200,
            ),
            child: Text(
              viewModel.articleDetail.content,
              style: FontSystem.H6,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  '${viewModel.articleDetail.createdAt} | ${viewModel.articleDetail.creator} | ${viewModel.articleDetail.commentCnt}의 댓글 ',
                  style: FontSystem.H6.copyWith(
                    color: ColorSystem.neutral,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          InfinityHorizonLine(
            gap: 1,
            color: ColorSystem.neutral.shade200,
          ),
        ],
      ),
    );
  }
}
