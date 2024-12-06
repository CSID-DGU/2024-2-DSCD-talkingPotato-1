import 'package:get/get.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/usecase/sync_no_condition_usecase.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';

class ReadArticleSearchTermListUseCase extends BaseUseCase
    implements SyncNoConditionUseCase<List<String>> {
  late final SearchTermRepository _searchTermRepository;

  @override
  void onInit() {
    _searchTermRepository = Get.find<SearchTermRepository>();

    super.onInit();
  }

  @override
  StateWrapper<List<String>> execute() {
    return _searchTermRepository.readArticleSearchTermList();
  }
}
