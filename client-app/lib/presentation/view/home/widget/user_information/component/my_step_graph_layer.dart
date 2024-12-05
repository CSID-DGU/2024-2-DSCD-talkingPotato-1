import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';

class MyStepGraphLayer extends StatelessWidget {
  const MyStepGraphLayer({
    super.key,
    required this.stepCount,
  });

  final int stepCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorSystem.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "오늘의 걸음 수",
            style: FontSystem.H4,
          ),
          Text(
            convertStepCountToCommaFormat(stepCount),
            style: FontSystem.H1,
          ),
          const SizedBox(
            height: 140,
            child: Center(
              child: Text(
                "그래프가 들어갈 자리",
                style: FontSystem.H4,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              "오늘은 평소보다 1082걸음 적게 걸었어요!!",
              style: FontSystem.Sub2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String convertStepCountToCommaFormat(int stepCount) {
    return stepCount.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }
}
