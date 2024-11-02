import 'package:flutter/material.dart';
import 'package:wooahan/app/config/color_system.dart';
import 'package:wooahan/app/utility/log_util.dart';
import 'package:wooahan/core/screen/base_widget.dart';
import 'package:wooahan/domain/entity/board_overview_state.dart';
import 'package:wooahan/presentation/view/board/widget/board_card/component/board_card_item_view.dart';
import 'package:wooahan/presentation/view_model/board/board_view_model.dart';
import 'package:wooahan/presentation/widget/line/infinity_horizon_line.dart';

class BoardCardListView extends BaseWidget<BoardViewModel> {
  const BoardCardListView({super.key});

  @override
  Widget buildView(BuildContext context) {
    List<BoardOverviewState> items = [
      BoardOverviewState(
        id: 1,
        title: '배고픔은 왜 배고플까요?',
        content: '배고픔에는 가짜 배고픔과 진짜 배고픔이 있습니다. '
            '이는 뇌에서 신호를 받는 방식에 따라 나뉩니다. '
            '하지만 뇌는 가짜 배고픔과 진짜 배고픔을 구분하지 못합니다. '
            '그래서 가짜 배고픔을 느끼면 진짜 배고픔으로 오해할 수 있습니다. '
            '이런 오해가 생기면 뇌는 더 많은 음식을 요구하게 되고, '
            '이는 체중 증가로 이어질 수 있습니다.',
        createdAt: '2024-10-29',
        creator: '무능한자',
      ),
      BoardOverviewState(
        id: 2,
        title: '암 환자들은 왜 살이 빠질까요?',
        content: '암 환자들은 종종 살이 빠지는 것을 경험합니다. '
            '이는 암이 발생하면서 발생하는 여러 요인에 의해 발생합니다. '
            '암은 신체의 에너지를 많이 소비하고, '
            '식욕을 감소시키는 물질을 분비하기 때문에 살이 빠질 수 있습니다. '
            '또한 암 환자들은 종종 항암 치료를 받기 때문에 '
            '치료로 인해 식욕이 감소하고, '
            '이로 인해 살이 빠질 수 있습니다.',
        createdAt: '2024-10-29',
        creator: '우리는의사',
      ),
      BoardOverviewState(
        id: 3,
        title: '운동과 배고픔의 관계',
        content: '운동을 하면 배고픔을 느끼게 됩니다. '
            '이는 운동을 하면 신체의 에너지 소비량이 증가하기 때문입니다. '
            '이는 신체의 에너지 소비량이 증가하면 '
            '신체는 에너지를 보충하기 위해 음식을 섭취해야 하기 때문입니다. '
            '따라서 운동을 하면 배고픔을 느끼게 되는 것입니다.',
        createdAt: '2024-10-29',
        creator: '운동광약사',
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
        return BoardCardItemView(
          state: items[index],
          onTap: () {
            LogUtil.info("BoardCardListView - onTap");
          },
        );
      },
    );
  }
}
