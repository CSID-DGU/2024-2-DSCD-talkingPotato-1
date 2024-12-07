import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/domain/entity/schedule/schedule_summary_state.dart';
import 'package:wooahan/presentation/widget/common/image/svg_image_view.dart';

class TimelineCardItemView extends StatelessWidget {
  const TimelineCardItemView({
    super.key,
    required this.state,
    required this.onTap,
  });

  final ScheduleSummaryState state;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (Get.width - 100) / 4,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: ColorSystem.white,
          borderRadius: BorderRadius.circular((Get.width - 100) / 8),
          boxShadow: [
            BoxShadow(
              color: ColorSystem.primary.withOpacity(0.2),
              offset: const Offset(0, 0),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            SvgImageView(
              assetPath: assetPath,
              width: (Get.width - 100) / 4 - 24 - 8,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: FontSystem.Sub1,
            ),
            const Spacer(),
            SizedBox(
              width: (Get.width - 100) / 4 - 24,
              child: CircularPercentIndicator(
                percent: state.percent,
                radius: ((Get.width - 100) / 4 - 24) / 2,
                lineWidth: 4,
                animation: true,
                animateFromLastPercent: true,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: ColorSystem.primary,
                backgroundColor: ColorSystem.primary.withOpacity(0.2),
                center: Text(
                  '${state.takenAmount}/${state.totalAmount}',
                  style: FontSystem.Sub3.copyWith(height: 1.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String get assetPath {
    switch (state.timeline) {
      case 'breakfast':
        return 'assets/icons/timeline_breakfast_${state.isNow ? 'active' : 'inactive'}.svg';
      case 'lunch':
        return 'assets/icons/timeline_lunch_${state.isNow ? 'active' : 'inactive'}.svg';
      case 'dinner':
        return 'assets/icons/timeline_dinner_${state.isNow ? 'active' : 'inactive'}.svg';
      case 'daily':
        return 'assets/icons/timeline_daily_${state.isNow ? 'active' : 'inactive'}.svg';
      default:
        throw Exception('Invalid timeline: ${state.timeline}');
    }
  }

  String get title {
    switch (state.timeline) {
      case 'breakfast':
        return '아침';
      case 'lunch':
        return '점심';
      case 'dinner':
        return '저녁';
      case 'daily':
        return '기타';
      default:
        throw Exception('Invalid timeline: ${state.timeline}');
    }
  }
}
