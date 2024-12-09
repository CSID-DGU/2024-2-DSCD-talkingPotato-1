import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/answer/answer_state.dart';

class AnswerDefaultItemView extends StatelessWidget {
  const AnswerDefaultItemView({
    super.key,
    required this.state,
  });

  final AnswerState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: ColorSystem.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.content,
            style: FontSystem.H6,
          ),
          const SizedBox(height: 4),
          if (state.creator != null)
            Text(
              '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.creator}',
              style: FontSystem.Sub3.copyWith(
                color: ColorSystem.neutral,
              ),
            )
          else
            Text(
              '${DateTimeUtil.calRemainDateTime(state.createdAt)} | 우아한 AI',
              style: FontSystem.Sub3.copyWith(
                color: ColorSystem.neutral,
              ),
            ),
        ],
      ),
    );
  }
}
