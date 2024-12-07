import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';
import 'package:wooahan/presentation/widget/common/image/network_image_view.dart';

class ArticleSummaryDefaultItemView extends StatelessWidget {
  const ArticleSummaryDefaultItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final ArticleSummaryState state;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: ColorSystem.white,
        child: Row(
          children: [
            SizedBox(
              width: Get.width - 40 - (state.thumbnailUrl == null ? 0 : 96),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      for (final tag in state.tags)
                        Container(
                          margin: const EdgeInsets.only(right: 4),
                          child: Text(
                            "#$tag",
                            style: FontSystem.Sub3.copyWith(
                              fontSize: 14,
                              color: ColorSystem.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Text(
                    state.title,
                    style: FontSystem.Sub1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    state.preview,
                    style: FontSystem.Sub3.copyWith(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 8),
                  const Spacer(),
                  Text(
                    '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.creator} | ${state.commentCnt}개의 댓글 ',
                    style: FontSystem.Sub3.copyWith(
                      fontSize: 14,
                      color: ColorSystem.neutral,
                    ),
                  ),
                ],
              ),
            ),
            if (state.thumbnailUrl != null) ...[
              const SizedBox(width: 16),
              NetworkImageView(
                imageUrl: state.thumbnailUrl!,
                width: 80,
                height: 80,
                borderRadius: BorderRadius.circular(8),
                backgroundColor: ColorSystem.neutral.shade100,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
