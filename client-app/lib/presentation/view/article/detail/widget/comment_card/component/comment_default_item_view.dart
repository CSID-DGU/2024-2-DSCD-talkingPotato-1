import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/comment/comment_state.dart';

class CommentDefaultItemView extends StatelessWidget {
  const CommentDefaultItemView({
    super.key,
    required this.state,
  });

  final CommentState state;

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
          Text(
            '${state.createdAt} | ${state.creator}',
            style: FontSystem.Sub3.copyWith(
              color: ColorSystem.neutral,
            ),
          ),
        ],
      ),
    );
  }
}
