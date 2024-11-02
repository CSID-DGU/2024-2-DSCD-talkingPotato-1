import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/domain/entity/question_overview_state.dart';
import 'package:wooahan/presentation/view/board/widget/dialogue_card/component/question_card_item_view.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/line/infinity_horizon_line.dart';

class QuestionCardListView extends BaseWidget<BoardViewModel> {
  const QuestionCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    List<QuestionOverviewState> items = [
      QuestionOverviewState(
        id: 1,
        question:
            '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
        createdAt: '2024-10-31',
        creator: '홍길동',
        answerType: 'pending',
      ),
      QuestionOverviewState(
        id: 2,
        question:
            '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
        createdAt: '2024-10-30',
        creator: '길동홍',
        answerType: 'answered_by_expert',
      ),
      QuestionOverviewState(
        id: 3,
        question:
            '요즘 관절염이 심해서 근이완제를 먹고 있는데 효과가 있나요? 효과가 없어서 다른 약을 찾아보려고 하는데 추천해주실 수 있나요?',
        createdAt: '2024-10-30',
        creator: '동홍길',
        answerType: 'answered_by_llm',
      ),
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: items.length,
      separatorBuilder: (context, index) {
        return InfinityHorizonLine(
          gap: 1,
          color: ColorSystem.neutral.shade200,
        );
      },
      itemBuilder: (context, index) {
        return QuestionCardItemView(
          state: items[index],
          onTap: () {},
        );
      },
    );
  }
}
