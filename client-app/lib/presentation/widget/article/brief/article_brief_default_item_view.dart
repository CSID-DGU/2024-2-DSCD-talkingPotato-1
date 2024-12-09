import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/article/article_brief_state.dart';

class ArticleBriefDefaultItemView extends StatelessWidget {
  const ArticleBriefDefaultItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final ArticleBriefState state;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 176,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: ColorSystem.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            const SizedBox(height: 8),
            const Spacer(),
            Text(
              '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.creator}',
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
