import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/config/font_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
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
              "${viewModel.isLoading ? 'OOO' : viewModel.nickname}님",
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
      top: 74 + 20,
      left: 0,
      right: 0,
      child: Container(
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
              "내가 작성한 최근 질문들",
              style: FontSystem.H4,
            ),
            Obx(
              () => ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewModel.questionBriefList.length,
                itemBuilder: (context, index) {
                  QuestionBriefState state = viewModel.questionBriefList[index];

                  if (state.id == 0) {
                    return const SizedBox(
                      height: 60,
                    );
                  }

                  String badgeText = '';
                  Color? backgroundColor;
                  Color? textColor;

                  switch (state.answerStatus) {
                    case 'NONE':
                      backgroundColor = ColorSystem.neutral.shade200;
                      textColor = ColorSystem.neutral;
                      badgeText = '답변 대기중';
                      break;
                    case 'EXPERT':
                      backgroundColor = ColorSystem.primary;
                      textColor = ColorSystem.white;
                      badgeText = '전문가 첫 답변';
                      break;
                    case 'AI':
                      backgroundColor = ColorSystem.blue;
                      textColor = ColorSystem.white;
                      badgeText = 'AI 첫 답변';
                      break;
                  }

                  return SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Get.width - 40 - 40 - 120,
                          child: Text(
                            viewModel.questionBriefList[index].preview,
                            style: FontSystem.Sub2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            badgeText,
                            style: FontSystem.Sub3.copyWith(
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => InfinityHorizonLine(
                  gap: 1,
                  color: ColorSystem.neutral.shade200,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
