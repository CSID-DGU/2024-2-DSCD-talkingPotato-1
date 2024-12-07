import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';

class CommentDefaultItemView extends StatelessWidget {
  const CommentDefaultItemView({
    super.key,
    required this.state,
    required this.onPressedRemove,
  });

  final CommentState state;
  final VoidCallback onPressedRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: ColorSystem.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (state.currentAccountId == state.creatorId)
                GestureDetector(
                  onTap: onPressedRemove,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    color: ColorSystem.transparent,
                    child: Text(
                      '삭제하기',
                      style: FontSystem.Sub3.copyWith(
                        color: ColorSystem.red,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Text(
            state.content,
            style: FontSystem.Sub3,
          ),
          const SizedBox(height: 8),
          Text(
            '${DateTimeUtil.calRemainDateTime(state.createdAt)} | ${state.creator}',
            style: FontSystem.Sub3.copyWith(
              fontSize: 14,
              color: ColorSystem.neutral,
            ),
          ),
        ],
      ),
    );
  }
}
