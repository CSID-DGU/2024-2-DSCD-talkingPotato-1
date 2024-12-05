import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/app/utility/date_time_util.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/question/detail/question_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class QuestionDetailView extends BaseWidget<QuestionDetailViewModel> {
  const QuestionDetailView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Obx(
          () => Container(
            constraints: const BoxConstraints(
              minHeight: 200,
            ),
            child: Text(
              viewModel.questionDetail.content,
              style: FontSystem.H6,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Obx(
              () {
                if (viewModel.isInitLoading) {
                  return const SizedBox(
                    height: 20,
                  );
                }
                return Text(
                  '${DateTimeUtil.calRemainDateTime(viewModel.questionDetail.createdAt)} | ${viewModel.questionDetail.creator} | ${viewModel.questionDetail.answerCnt}개의 답변',
                  style: FontSystem.H6.copyWith(
                    color: ColorSystem.neutral,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 32),
        InfinityHorizonLine(
          gap: 1,
          color: ColorSystem.neutral.shade200,
        ),
      ],
    );
  }
}
