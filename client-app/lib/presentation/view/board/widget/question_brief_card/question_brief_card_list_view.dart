import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';
import 'package:wooahan/presentation/widget/question/brief/question_brief_default_item_view.dart';

class QuestionBriefCardListView extends BaseWidget<BoardViewModel> {
  const QuestionBriefCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () {
        if (viewModel.isLoading) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(ColorSystem.primary),
              ),
            ),
          );
        }

        if (viewModel.questionBriefList.isEmpty) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                '질문이 없습니다.',
                style: FontSystem.H5.copyWith(
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
          itemCount: viewModel.questionBriefList.length,
          separatorBuilder: (context, index) {
            return InfinityHorizonLine(
              gap: 1,
              color: ColorSystem.neutral.shade200,
            );
          },
          itemBuilder: (context, index) {
            return QuestionBriefDefaultItemView(
              state: viewModel.questionBriefList[index],
              onTap: () {
                Get.toNamed(
                  "${AppRoutes.QUESTION}/detail/${viewModel.questionBriefList[index].id}",
                );
              },
            );
          },
        );
      },
    );
  }
}
