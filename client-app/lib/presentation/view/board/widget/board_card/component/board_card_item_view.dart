import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/board_overview_state.dart';

class BoardCardItemView extends StatelessWidget {
  const BoardCardItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final BoardOverviewState state;
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
              state.title,
              style: FontSystem.H6,
            ),
            const SizedBox(height: 4),
            Text(
              state.content,
              style: FontSystem.Sub3,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
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
      ),
    );
  }
}
