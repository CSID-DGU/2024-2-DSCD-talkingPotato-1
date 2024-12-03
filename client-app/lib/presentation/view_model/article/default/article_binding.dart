import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/article/read_article_summary_list_use_case.dart';
import 'package:wooahan/presentation/view_model/article/default/article_view_model.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadArticleSummaryListUseCase>(
      () => ReadArticleSummaryListUseCase(),
    );

    Get.lazyPut<ArticleViewModel>(() => ArticleViewModel());
  }
}
