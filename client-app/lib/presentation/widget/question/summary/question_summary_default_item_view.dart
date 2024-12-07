import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';

class QuestionSummaryDefaultItemView extends StatelessWidget {
  const QuestionSummaryDefaultItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final QuestionSummaryState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: ColorSystem.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.preview,
              style: FontSystem.Sub3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.creator} | ${state.answerCnt}개의 답변',
                  style: FontSystem.Sub3.copyWith(
                    fontSize: 14,
                    color: ColorSystem.neutral,
                  ),
                ),
                const Spacer(),
                _buildBadgeView(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeView() {
    String badgeText = '';
    Color? backgroundColor;
    Color? textColor;

    switch (state.answerStatus) {
      case 'NONE':
        backgroundColor = ColorSystem.neutral.shade200;
        textColor = ColorSystem.neutral;
        badgeText = '답변 대기중';
        break;
      case 'EXPERT':
        backgroundColor = ColorSystem.primary;
        textColor = ColorSystem.white;
        badgeText = '전문가 첫 답변';
        break;
      case 'AI':
        backgroundColor = ColorSystem.blue;
        textColor = ColorSystem.white;
        badgeText = 'AI 첫 답변';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badgeText,
        style: FontSystem.Sub3.copyWith(
          color: textColor,
          height: 1.0,
        ),
      ),
    );
  }
}
