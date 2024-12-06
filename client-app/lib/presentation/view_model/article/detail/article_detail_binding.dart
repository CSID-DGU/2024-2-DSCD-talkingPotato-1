import 'package:get/get.dart';
import 'package:wooahan/domain/usecase/article/read_article_detail_use_case.dart';
import 'package:wooahan/domain/usecase/comment/delete_article_comment_use_case.dart';
import 'package:wooahan/domain/usecase/comment/read_article_comment_list_use_case.dart';
import 'package:wooahan/presentation/view_model/article/detail/article_detail_view_model.dart';

class ArticleDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReadArticleDetailUseCase>(
      () => ReadArticleDetailUseCase(),
    );
    Get.lazyPut<ReadArticleCommentListUseCase>(
      () => ReadArticleCommentListUseCase(),
    );
    Get.lazyPut<DeleteArticleCommentUseCase>(
      () => DeleteArticleCommentUseCase(),
    );

    Get.lazyPut<ArticleDetailViewModel>(() => ArticleDetailViewModel());
  }
}
