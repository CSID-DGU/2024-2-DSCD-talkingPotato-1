import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/app_routes.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/presentation/view/home/widget/user_information/component/question_mini_default_item_view.dart';
import 'package:wooahan/presentation/view_model/home/home_view_model.dart';
import 'package:wooahan/presentation/widget/common/line/infinity_horizon_line.dart';

class UserInformationView extends BaseWidget<HomeViewModel> {
  const UserInformationView({super.key});

  @override
  Widget buildView(BuildContext context) {
    return SizedBox(
      height: 368,
      child: Stack(
        children: [
          _buildNicknameLayer(),
          _buildMyQuestionsLayer(),
        ],
      ),
    );
  }

  Widget _buildNicknameLayer() {
    return Obx(
      () => Container(
        width: Get.width,
        height: 240,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorSystem.primary,
              ColorSystem.primary.shade400,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: ColorSystem.black.withOpacity(0.1),
              offset: const Offset(0, 4),
              blurRadius: 4,
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "${viewModel.isInitLoading ? 'OOO' : viewModel.nickname}님",
              style: FontSystem.H1.copyWith(
                color: ColorSystem.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "오늘 하루는 어떠셨나요?",
              style: FontSystem.H5.copyWith(
                color: ColorSystem.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyQuestionsLayer() {
    return Positioned(
      top: 74 + 32,
      left: 0,
      right: 0,
      child: Container(
        height: 260,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "내가 작성한 최근 질문들",
                  style: FontSystem.H4,
                ),
                GestureDetector(
                  onTap: viewModel.onRefresh,
                  child: Row(
                    children: [
                      Text(
                        "새로고침",
                        style: FontSystem.Sub3.copyWith(
                          color: ColorSystem.primary,
                        ),
                      ),
                      const Icon(
                        Icons.refresh,
                        size: 16,
                        color: ColorSystem.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Obx(
              () {
                if (viewModel.isMoreLoading || viewModel.isInitLoading) {
                  return const Expanded(
                      child: Center(child: CircularProgressIndicator()));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.questionBriefList.length,
                  itemBuilder: (context, index) {
                    if (viewModel.questionBriefList[index].id == 0) {
                      Widget? child;

                      if (index == 0 ||
                          (viewModel.questionBriefList[index - 1].id != 0)) {
                        child = Text(
                          "더 이상 작성한 질문이 없습니다.",
                          style: FontSystem.H6.copyWith(
                            color: ColorSystem.neutral.shade400,
                          ),
                        );
                      }

                      return SizedBox(
                        height: 60,
                        child: Center(
                          child: child,
                        ),
                      );
                    }

                    return QuestionMiniDefaultItemView(
                      state: viewModel.questionBriefList[index],
                      onTap: () {
                        Get.toNamed(
                          "${AppRoutes.QUESTION}/detail/${viewModel.questionBriefList[index].id}",
                        );
                      },
                    );
                  },
                  separatorBuilder: (context, index) => InfinityHorizonLine(
                    gap: 1,
                    color: ColorSystem.neutral.shade200,
                  ),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
