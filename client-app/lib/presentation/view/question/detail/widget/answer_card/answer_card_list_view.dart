import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/question/detail/widget/answer_card/component/answer_default_item_view.dart';
import 'package:wooahan/presentation/view_model/question/detail/question_detail_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class AnswerCardListView extends BaseWidget<QuestionDetailViewModel> {
  const AnswerCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        if (viewModel.isInitLoading) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorSystem.primary),
              ),
            ),
          );
        }

        if (viewModel.answerList.isEmpty) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                '답변이 없습니다.',
                style: FontSystem.H6.copyWith(
                  color: ColorSystem.neutral.shade600,
                ),
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: viewModel.answerList.length,
          separatorBuilder: (context, index) {
            return InfinityHorizonLine(
              gap: 1,
              color: ColorSystem.neutral.shade200,
            );
          },
          itemBuilder: (context, index) {
            return AnswerDefaultItemView(
              state: viewModel.answerList[index],
            );
          },
        );
      },
    );
  }
}
