import 'package:get/get.dart';
import 'package:wooahan/data/provider/article/article_remote_provider.dart';
import 'package:wooahan/data/provider/article/article_remote_provider_impl.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider_impl.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider_impl.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider_impl.dart';
import 'package:wooahan/data/repository/article/article_repository_impl.dart';
import 'package:wooahan/data/repository/comment/comment_repository_impl.dart';
import 'package:wooahan/data/repository/drug/drug_repository_impl.dart';
import 'package:wooahan/data/repository/schedule/schedule_repository_impl.dart';
import 'package:wooahan/data/repository/search_term/search_term_repository_impl.dart';
import 'package:wooahan/domain/repository/article/article_repository.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';

class AppDependency extends Bindings {
  @override
  void dependencies() {
    // Add your mediator dependencies here

    // Add your provider dependencies here
    Get.lazyPut<DrugRemoteProvider>(() => DrugRemoteProviderImpl());
    Get.lazyPut<ScheduleRemoteProvider>(() => ScheduleRemoteProviderImpl());
    Get.lazyPut<ArticleRemoteProvider>(() => ArticleRemoteProviderImpl());
    Get.lazyPut<CommentRemoteProvider>(() => CommentRemoteProviderImpl());

    // Add your repository dependencies here
    Get.lazyPut<DrugRepository>(() => DrugRepositoryImpl());
    Get.lazyPut<ScheduleRepository>(() => ScheduleRepositoryImpl());
    Get.lazyPut<ArticleRepository>(() => ArticleRepositoryImpl());
    Get.lazyPut<CommentRepository>(() => CommentRepositoryImpl());

    Get.lazyPut<SearchTermRepository>(() => SearchTermRepositoryImpl());
  }
}
