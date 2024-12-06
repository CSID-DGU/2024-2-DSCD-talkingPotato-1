import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/search_term/upsert_article_search_term_list_condition.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';

class UpsertArticleSearchTermListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<void, UpsertArticleSearchTermListCondition> {
  late final SearchTermRepository _searchTermRepository;

  @override
  void onInit() {
    _searchTermRepository = Get.find<SearchTermRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpsertArticleSearchTermListCondition condition,
  ) async {
    await _searchTermRepository.upsertArticleSearchTermList(condition);

    return StateWrapper(success: true);
  }
}
