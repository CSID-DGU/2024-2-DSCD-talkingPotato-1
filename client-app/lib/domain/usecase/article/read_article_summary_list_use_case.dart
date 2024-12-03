import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_summary_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';
import 'package:wooahan/domain/repository/article/article_repository.dart';

class ReadArticleSummaryListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<List<ArticleSummaryState>,
            ReadArticleSummaryListCondition> {
  late final ArticleRepository _articleRepository;

  @override
  void onInit() {
    _articleRepository = Get.find<ArticleRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<ArticleSummaryState>>> execute(
    ReadArticleSummaryListCondition condition,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(
      success: true,
      data: [
        ArticleSummaryState(
          id: 1,
          title: '배고픔은 왜 배고플까요?',
          preview: '배고픔에는 가짜 배고픔과 진짜 배고픔이 있습니다. '
              '이는 뇌에서 신호를 받는 방식에 따라 나뉩니다. '
              '하지만 뇌는 가짜 배고픔과 진짜 배고픔을 구분하지 못합니다. '
              '그래서 가짜 배고픔을 느끼면 진짜 배고픔으로 오해할 수 있습니다. '
              '이런 오해가 생기면 뇌는 더 많은 음식을 요구하게 되고, '
              '이는 체중 증가로 이어질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '무능한자',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 3,
        ),
        ArticleSummaryState(
          id: 2,
          title: '암 환자들은 왜 살이 빠질까요?',
          preview: '암 환자들은 종종 살이 빠지는 것을 경험합니다. '
              '이는 암이 발생하면서 발생하는 여러 요인에 의해 발생합니다. '
              '암은 신체의 에너지를 많이 소비하고, '
              '식욕을 감소시키는 물질을 분비하기 때문에 살이 빠질 수 있습니다. '
              '또한 암 환자들은 종종 항암 치료를 받기 때문에 '
              '치료로 인해 식욕이 감소하고, '
              '이로 인해 살이 빠질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '우리는의사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 17,
        ),
        ArticleSummaryState(
          id: 3,
          title: '운동과 배고픔의 관계',
          preview: '운동을 하면 배고픔을 느끼게 됩니다. '
              '이는 운동을 하면 신체의 에너지 소비량이 증가하기 때문입니다. '
              '이는 신체의 에너지 소비량이 증가하면 '
              '신체는 에너지를 보충하기 위해 음식을 섭취해야 하기 때문입니다. '
              '따라서 운동을 하면 배고픔을 느끼게 되는 것입니다.',
          createdAt: '2024-10-29',
          creator: '운동광약사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 32,
        ),
        ArticleSummaryState(
          id: 4,
          title: '배고픔은 왜 배고플까요?',
          preview: '배고픔에는 가짜 배고픔과 진짜 배고픔이 있습니다. '
              '이는 뇌에서 신호를 받는 방식에 따라 나뉩니다. '
              '하지만 뇌는 가짜 배고픔과 진짜 배고픔을 구분하지 못합니다. '
              '그래서 가짜 배고픔을 느끼면 진짜 배고픔으로 오해할 수 있습니다. '
              '이런 오해가 생기면 뇌는 더 많은 음식을 요구하게 되고, '
              '이는 체중 증가로 이어질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '무능한자',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 3,
        ),
        ArticleSummaryState(
          id: 5,
          title: '암 환자들은 왜 살이 빠질까요?',
          preview: '암 환자들은 종종 살이 빠지는 것을 경험합니다. '
              '이는 암이 발생하면서 발생하는 여러 요인에 의해 발생합니다. '
              '암은 신체의 에너지를 많이 소비하고, '
              '식욕을 감소시키는 물질을 분비하기 때문에 살이 빠질 수 있습니다. '
              '또한 암 환자들은 종종 항암 치료를 받기 때문에 '
              '치료로 인해 식욕이 감소하고, '
              '이로 인해 살이 빠질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '우리는의사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 17,
        ),
        ArticleSummaryState(
          id: 6,
          title: '운동과 배고픔의 관계',
          preview: '운동을 하면 배고픔을 느끼게 됩니다. '
              '이는 운동을 하면 신체의 에너지 소비량이 증가하기 때문입니다. '
              '이는 신체의 에너지 소비량이 증가하면 '
              '신체는 에너지를 보충하기 위해 음식을 섭취해야 하기 때문입니다. '
              '따라서 운동을 하면 배고픔을 느끼게 되는 것입니다.',
          createdAt: '2024-10-29',
          creator: '운동광약사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 32,
        ),
        ArticleSummaryState(
          id: 7,
          title: '배고픔은 왜 배고플까요?',
          preview: '배고픔에는 가짜 배고픔과 진짜 배고픔이 있습니다. '
              '이는 뇌에서 신호를 받는 방식에 따라 나뉩니다. '
              '하지만 뇌는 가짜 배고픔과 진짜 배고픔을 구분하지 못합니다. '
              '그래서 가짜 배고픔을 느끼면 진짜 배고픔으로 오해할 수 있습니다. '
              '이런 오해가 생기면 뇌는 더 많은 음식을 요구하게 되고, '
              '이는 체중 증가로 이어질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '무능한자',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 3,
        ),
        ArticleSummaryState(
          id: 8,
          title: '암 환자들은 왜 살이 빠질까요?',
          preview: '암 환자들은 종종 살이 빠지는 것을 경험합니다. '
              '이는 암이 발생하면서 발생하는 여러 요인에 의해 발생합니다. '
              '암은 신체의 에너지를 많이 소비하고, '
              '식욕을 감소시키는 물질을 분비하기 때문에 살이 빠질 수 있습니다. '
              '또한 암 환자들은 종종 항암 치료를 받기 때문에 '
              '치료로 인해 식욕이 감소하고, '
              '이로 인해 살이 빠질 수 있습니다.',
          createdAt: '2024-10-29',
          creator: '우리는의사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 17,
        ),
        ArticleSummaryState(
          id: 9,
          title: '운동과 배고픔의 관계',
          preview: '운동을 하면 배고픔을 느끼게 됩니다. '
              '이는 운동을 하면 신체의 에너지 소비량이 증가하기 때문입니다. '
              '이는 신체의 에너지 소비량이 증가하면 '
              '신체는 에너지를 보충하기 위해 음식을 섭취해야 하기 때문입니다. '
              '따라서 운동을 하면 배고픔을 느끼게 되는 것입니다.',
          createdAt: '2024-10-29',
          creator: '운동광약사',
          tags: ['배고픔', '식욕', '뇌'],
          commentCnt: 32,
        ),
      ],
    );

    return await _articleRepository.readArticleSummaryList(condition);
  }
}
