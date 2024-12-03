import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/article/read_article_summary_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/read_article_search_term_list_use_case.dart';
import 'package:wooahan/domain/usecase/search_term/upsert_article_search_term_list_use_case.dart';
import 'package:wooahan/presentation/view_model/article/searching/article_searching_view_model.dart';

class ArticleSearchingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadArticleSummaryListUseCase>(
      () => ReadArticleSummaryListUseCase(),
    );
    Get.lazyPut<ReadArticleSearchTermListUseCase>(
      () => ReadArticleSearchTermListUseCase(),
    );
    Get.lazyPut<UpsertArticleSearchTermListUseCase>(
      () => UpsertArticleSearchTermListUseCase(),
    );

    Get.lazyPut<ArticleSearchingViewModel>(() => ArticleSearchingViewModel());
  }
}
