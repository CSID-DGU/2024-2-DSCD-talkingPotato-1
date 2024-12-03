import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/search_term/upsert_question_search_term_list_condition.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';

class UpsertQuestionSearchTermListUseCase extends BaseUseCase
    implements
        AsyncConditionUseCase<void, UpsertQuestionSearchTermListCondition> {
  late final SearchTermRepository _searchTermRepository;

  @override
  void onInit() {
    _searchTermRepository = Get.find<SearchTermRepository>();

    super.onInit();
  }

  @override
  Future<StateWrapper<void>> execute(
    UpsertQuestionSearchTermListCondition condition,
  ) async {
    await _searchTermRepository.upsertQuestionSearchTermList(condition);

    return StateWrapper(success: true);
  }
}
