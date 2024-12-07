import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view_model/question/searching/question_searching_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';
import 'package:wooahan/presentation/widget/question/summary/question_summary_default_item_view.dart';

class QuestionResultView extends BaseWidget<QuestionSearchingViewModel> {
  const QuestionResultView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        _buildHeaderView(),
        if (viewModel.mode == 'searching') const SizedBox(height: 16),
        _buildContentView(),
      ],
    );
  }

  Widget _buildHeaderView() {
    return Obx(() {
      if (viewModel.mode == 'searching') {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "최근 검색",
              style: FontSystem.H5.copyWith(
                color: ColorSystem.neutral.shade600,
              ),
            ),
            GestureDetector(
              onTap: viewModel.removeAllInRecentSearchTermList,
              child: Text(
                "전체 삭제",
                style: FontSystem.Sub2.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorSystem.neutral,
                ),
              ),
            )
          ],
        );
      }

      return const SizedBox();
    });
  }

  Widget _buildContentView() {
    return Obx(() {
      if (viewModel.mode == 'searching') {
        if (viewModel.recentSearchTermList.isEmpty) {
          return SizedBox(
            height: 120,
            child: Center(
              child: Text(
                '최근 검색어가 없습니다.',
                style: FontSystem.Sub3.copyWith(
                  color: ColorSystem.neutral.shade600,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: viewModel.recentSearchTermList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                viewModel.updateSearchTermBySearchTermItem(index);
                viewModel.updateArticleSummaryList();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 20,
                      color: ColorSystem.neutral.shade600,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      viewModel.recentSearchTermList[index],
                      style: FontSystem.H6.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorSystem.neutral.shade600,
                        height: 1.0,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        viewModel.removeInRecentSearchTerm(index);
                      },
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: ColorSystem.neutral.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

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

      if (viewModel.questionSummaryList.isEmpty) {
        return SizedBox(
          height: 120,
          child: Center(
            child: Text(
              '검색 결과가 없습니다.',
              style: TextStyle(
                color: ColorSystem.neutral.shade600,
                fontSize: 16,
              ),
            ),
          ),
        );
      }

      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: viewModel.questionSummaryList.length,
        separatorBuilder: (context, index) {
          return InfinityHorizonLine(
            gap: 1,
            color: ColorSystem.neutral.shade200,
          );
        },
        itemBuilder: (context, index) {
          return QuestionSummaryDefaultItemView(
            state: viewModel.questionSummaryList[index],
            onTap: () {
              Get.toNamed(
                '${AppRoutes.QUESTION}/detail/${viewModel.questionSummaryList[index].id}',
              );
            },
          );
        },
      );
    });
  }
}
