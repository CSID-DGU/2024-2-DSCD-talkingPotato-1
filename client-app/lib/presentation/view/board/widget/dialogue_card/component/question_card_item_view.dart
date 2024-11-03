import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/question_overview_state.dart';

class QuestionCardItemView extends StatelessWidget {
  const QuestionCardItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final QuestionOverviewState state;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: ColorSystem.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.question,
              style: FontSystem.Sub3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '${state.createdAt} | ${state.creator}',
                  style: FontSystem.Sub3.copyWith(
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

    switch (state.answerType) {
      case 'pending':
        backgroundColor = ColorSystem.neutral.shade200;
        textColor = ColorSystem.neutral;
        badgeText = '답변 대기중';
        break;
      case 'answered_by_expert':
        backgroundColor = ColorSystem.primary;
        textColor = ColorSystem.white;
        badgeText = '전문가 첫 답변';
        break;
      case 'answered_by_llm':
        backgroundColor = ColorSystem.blue;
        textColor = ColorSystem.white;
        badgeText = 'AI 첫 답변';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        badgeText,
        style: FontSystem.Sub3.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
