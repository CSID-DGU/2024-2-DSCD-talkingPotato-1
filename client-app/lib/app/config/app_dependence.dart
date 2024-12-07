import 'package:get/get.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/data/provider/account/account_remote_provider.dart';
import 'package:wooahan/data/provider/account/account_remote_provider_impl.dart';
import 'package:wooahan/data/provider/analysis/analysis_remote_provider.dart';
import 'package:wooahan/data/provider/analysis/analysis_remote_provider_impl.dart';
import 'package:wooahan/data/provider/answer/answer_remote_provider.dart';
import 'package:wooahan/data/provider/answer/answer_remote_provider_impl.dart';
import 'package:wooahan/data/provider/article/article_remote_provider.dart';
import 'package:wooahan/data/provider/article/article_remote_provider_impl.dart';
import 'package:wooahan/data/provider/auth/auth_provider.dart';
import 'package:wooahan/data/provider/auth/auth_provider_impl.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider.dart';
import 'package:wooahan/data/provider/comment/comment_remote_provider_impl.dart';
import 'package:wooahan/data/provider/correction/correction_remote_provider.dart';
import 'package:wooahan/data/provider/correction/correction_remote_provider_impl.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider.dart';
import 'package:wooahan/data/provider/drug/drug_remote_provider_impl.dart';
import 'package:wooahan/data/provider/medication/medication_remote_provider.dart';
import 'package:wooahan/data/provider/medication/medication_remote_provider_impl.dart';
import 'package:wooahan/data/provider/question/question_remote_provider.dart';
import 'package:wooahan/data/provider/question/question_remote_provider_impl.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider.dart';
import 'package:wooahan/data/provider/schedule/schedule_remote_provider_impl.dart';
import 'package:wooahan/data/provider/user/user_remote_provider.dart';
import 'package:wooahan/data/provider/user/user_remote_provider_impl.dart';
import 'package:wooahan/data/repository/account/account_repository_impl.dart';
import 'package:wooahan/data/repository/analysis/analysis_repository_impl.dart';
import 'package:wooahan/data/repository/answer/answer_repository_impl.dart';
import 'package:wooahan/data/repository/article/article_repository_impl.dart';
import 'package:wooahan/data/repository/auth/auth_repository_impl.dart';
import 'package:wooahan/data/repository/comment/comment_repository_impl.dart';
import 'package:wooahan/data/repository/correction/correction_repository_impl.dart';
import 'package:wooahan/data/repository/drug/drug_repository_impl.dart';
import 'package:wooahan/data/repository/medication/medication_repository_impl.dart';
import 'package:wooahan/data/repository/question/question_repository_impl.dart';
import 'package:wooahan/data/repository/schedule/schedule_repository_impl.dart';
import 'package:wooahan/data/repository/search_term/search_term_repository_impl.dart';
import 'package:wooahan/data/repository/user/user_repository_impl.dart';
import 'package:wooahan/domain/repository/account/account_repository.dart';
import 'package:wooahan/domain/repository/analysis/analysis_repository.dart';
import 'package:wooahan/domain/repository/answer/answer_repository.dart';
import 'package:wooahan/domain/repository/article/article_repository.dart';
import 'package:wooahan/domain/repository/auth/auth_repository.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';
import 'package:wooahan/domain/repository/correction/correction_repository.dart';
import 'package:wooahan/domain/repository/drug/drug_repository.dart';
import 'package:wooahan/domain/repository/medication/medication_repository.dart';
import 'package:wooahan/domain/repository/question/question_repository.dart';
import 'package:wooahan/domain/repository/schedule/schedule_repository.dart';
import 'package:wooahan/domain/repository/search_term/search_term_repository.dart';
import 'package:wooahan/domain/repository/user/user_repository.dart';

class AppDependency extends Bindings {
  @override
  void dependencies() {
    // Add your mediator dependencies here
    Get.lazyPut<BaseMediator>(() => BaseMediator());

    // Add your provider dependencies here
    Get.lazyPut<DrugRemoteProvider>(() => DrugRemoteProviderImpl());
    Get.lazyPut<AnalysisRemoteProvider>(() => AnalysisRemoteProviderImpl());

    Get.lazyPut<CorrectionRemoteProvider>(() => CorrectionRemoteProviderImpl());

    Get.lazyPut<AuthProvider>(() => AuthProviderImpl());
    Get.lazyPut<AccountRemoteProvider>(() => AccountRemoteProviderImpl());
    Get.lazyPut<UserRemoteProvider>(() => UserRemoteProviderImpl());
    Get.lazyPut<ScheduleRemoteProvider>(() => ScheduleRemoteProviderImpl());
    Get.lazyPut<ArticleRemoteProvider>(() => ArticleRemoteProviderImpl());
    Get.lazyPut<CommentRemoteProvider>(() => CommentRemoteProviderImpl());
    Get.lazyPut<QuestionRemoteProvider>(() => QuestionRemoteProviderImpl());
    Get.lazyPut<AnswerRemoteProvider>(() => AnswerRemoteProviderImpl());
    Get.lazyPut<MedicationRemoteProvider>(() => MedicationRemoteProviderImpl());

    // Add your repository dependencies here
    Get.lazyPut<SearchTermRepository>(() => SearchTermRepositoryImpl());

    Get.lazyPut<DrugRepository>(() => DrugRepositoryImpl());
    Get.lazyPut<AnalysisRepository>(() => AnalysisRepositoryImpl());

    Get.lazyPut<CorrectionRepository>(() => CorrectionRepositoryImpl());

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl());
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl());
    Get.lazyPut<ScheduleRepository>(() => ScheduleRepositoryImpl());
    Get.lazyPut<ArticleRepository>(() => ArticleRepositoryImpl());
    Get.lazyPut<CommentRepository>(() => CommentRepositoryImpl());
    Get.lazyPut<QuestionRepository>(() => QuestionRepositoryImpl());
    Get.lazyPut<AnswerRepository>(() => AnswerRepositoryImpl());
    Get.lazyPut<MedicationRepository>(() => MedicationRepositoryImpl());
  }
}
