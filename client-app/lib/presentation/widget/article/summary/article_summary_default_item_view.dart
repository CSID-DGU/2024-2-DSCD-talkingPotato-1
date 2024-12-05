import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: ColorSystem.white,
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
                        color: ColorSystem.primary,
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              state.title,
              style: FontSystem.H6,
            ),
            const SizedBox(height: 4),
            Text(
              state.preview,
              style: FontSystem.Sub3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Text(
              '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.commentCnt}개의 댓글 ',
              style: FontSystem.Sub3.copyWith(
                color: ColorSystem.neutral,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
