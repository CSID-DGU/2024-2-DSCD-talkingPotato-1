import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_detail_condition.dart';
import 'package:wooahan/domain/entity/article/article_detail_state.dart';
import 'package:wooahan/domain/repository/article/article_repository.dart';

class ReadArticleDetailUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<ArticleDetailState, ReadArticleDetailCondition> {
  late final ArticleRepository _articleRepository;

  @override
  void onInit() {
    _articleRepository = Get.find<ArticleRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<ArticleDetailState>> execute(
    ReadArticleDetailCondition condition,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    return StateWrapper(
      success: true,
      data: ArticleDetailState(
        id: 1,
        title: 'title',
        content: 'content',
        createdAt: '2024-10-01',
        creator: 'creator',
        tags: ['tag1', 'tag2'],
        commentCnt: 0,
      ),
    );

    return await _articleRepository.readArticleDetail(condition);
  }
}
