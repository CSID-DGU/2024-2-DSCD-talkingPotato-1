import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';

class QuestionMiniDefaultItemView extends StatelessWidget {
  const QuestionMiniDefaultItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final QuestionBriefState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            SizedBox(
              width: Get.width - 40 - 40 - 120,
              child: Text(
                state.preview,
                style: FontSystem.Sub3,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            _buildBadgeView(),
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
