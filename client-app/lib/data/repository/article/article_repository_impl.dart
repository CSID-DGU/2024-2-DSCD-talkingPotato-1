import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/response_wrapper.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/data/provider/article/article_remote_provider.dart';
import 'package:wooahan/domain/condition/article/read_article_brief_list_condition.dart';
import 'package:wooahan/domain/condition/article/read_article_detail_condition.dart';
import 'package:wooahan/domain/condition/article/read_article_summary_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_brief_state.dart';
import 'package:wooahan/domain/entity/article/article_detail_state.dart';
import 'package:wooahan/domain/entity/article/article_summary_state.dart';
import 'package:wooahan/domain/repository/article/article_repository.dart';

class ArticleRepositoryImpl extends GetxService implements ArticleRepository {
  late final ArticleRemoteProvider _remoteProvider;

  @override
  void onInit() {
    _remoteProvider = Get.find<ArticleRemoteProvider>();

    super.onInit();
  }

  @override
  Future<StateWrapper<List<ArticleBriefState>>> readArticleBriefList(
    ReadArticleBriefListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getArticleList(
      page: condition.page.toString(),
      size: condition.size.toString(),
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<ArticleBriefState> articleBriefList = response.data!['articles']
        .map<ArticleBriefState>(
          (article) => ArticleBriefState.fromJson(article),
        )
        .toList();

    return StateWrapper(
      success: true,
      data: articleBriefList,
    );
  }

  @override
  Future<StateWrapper<List<ArticleSummaryState>>> readArticleSummaryList(
    ReadArticleSummaryListCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getArticleList(
      q: condition.searchTerm,
      page: condition.page.toString(),
      size: condition.size.toString(),
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    List<ArticleSummaryState> articleSummaryList = response.data!['articles']
        .map<ArticleSummaryState>(
          (article) => ArticleSummaryState.fromJson(article),
        )
        .toList();

    return StateWrapper(
      success: true,
      data: articleSummaryList,
    );
  }

  @override
  Future<StateWrapper<ArticleDetailState>> readArticleDetail(
    ReadArticleDetailCondition condition,
  ) async {
    ResponseWrapper response = await _remoteProvider.getArticle(
      articleId: condition.articleId,
    );

    if (response.isFailure) {
      return StateWrapper(
        success: false,
        message: response.message,
      );
    }

    ArticleDetailState articleDetail =
        ArticleDetailState.fromJson(response.data!);

    return StateWrapper(
      success: true,
      data: articleDetail,
    );
  }
}
