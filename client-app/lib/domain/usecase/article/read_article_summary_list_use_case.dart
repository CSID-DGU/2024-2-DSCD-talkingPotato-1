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
    return await _articleRepository.readArticleSummaryList(condition);
  }
}
