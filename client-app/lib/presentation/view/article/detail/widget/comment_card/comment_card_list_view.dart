import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/article/detail/widget/comment_card/component/comment_default_item_view.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/dialog/confirm_dialog.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class CommentCardListView extends BaseWidget<ArticleDetailViewModel> {
  const CommentCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
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

        if (viewModel.articleCommentList.isEmpty) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                '댓글이 없습니다.',
                style: FontSystem.H6.copyWith(
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
          itemCount: viewModel.articleCommentList.length,
          separatorBuilder: (context, index) {
            return InfinityHorizonLine(
              gap: 1,
              color: ColorSystem.neutral.shade200,
            );
          },
          itemBuilder: (context, index) {
            return CommentDefaultItemView(
              state: viewModel.articleCommentList[index],
              onPressedRemove: () {
                Get.dialog(
                  ConfirmDialog(
                    title: '댓글 삭제',
                    content: '해당 댓글을 삭제하시겠습니까?',
                    onPressedApply: () {
                      viewModel.deleteArticleComment(index).then(
                        (_) {
                          Get.back();
                        },
                      );
                    },
                    onPressedCancel: Get.back,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
