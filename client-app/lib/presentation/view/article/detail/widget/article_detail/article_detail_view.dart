import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
    return Column(
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
        Obx(
          () => Markdown(
            data: viewModel.articleDetail.content,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            styleSheet: MarkdownStyleSheet(
              p: FontSystem.Sub2.copyWith(
                fontSize: 16,
                height: 1.5,
                color: ColorSystem.neutral.shade900,
              ),
              h1: FontSystem.H1.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h1Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              h2: FontSystem.H2.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h2Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              h3: FontSystem.H3.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h3Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              h4: FontSystem.H4.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h4Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              h5: FontSystem.H5.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h5Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              h6: FontSystem.Sub2.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              h6Padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
              blockquote: FontSystem.Sub2.copyWith(
                color: ColorSystem.neutral.shade900,
              ),
              blockquoteDecoration: BoxDecoration(
                color: ColorSystem.neutral.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              code: FontSystem.Sub2.copyWith(
                color: ColorSystem.red,
                backgroundColor: ColorSystem.neutral.shade100,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () => Text(
                '${viewModel.articleDetail.createdAt} | ${viewModel.articleDetail.creator} | ${viewModel.articleDetail.commentCnt}개의 댓글 ',
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
    );
  }
}
