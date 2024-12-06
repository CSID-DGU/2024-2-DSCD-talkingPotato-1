import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_brief_list_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_brief_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_brief_state.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_brief_list_use_case.dart';
import 'package:wooahan/domain/usecase/question/read_question_brief_list_use_case.dart';

class BoardViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadArticleBriefListUseCase _readArticleBriefListUseCase;
  late final ReadQuestionBriefListUseCase _readQuestionBriefListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;
  late final RxList<ArticleBriefState> _articleBriefList;
  late final RxList<QuestionBriefState> _questionBriefList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isLoading.value;
  List<ArticleBriefState> get articleBriefList => _articleBriefList;
  List<QuestionBriefState> get questionBriefList => _questionBriefList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readArticleBriefListUseCase = Get.find<ReadArticleBriefListUseCase>();
    _readQuestionBriefListUseCase = Get.find<ReadQuestionBriefListUseCase>();

    _isLoading = true.obs;
    _articleBriefList = <ArticleBriefState>[].obs;
    _questionBriefList = <QuestionBriefState>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    _isLoading.value = true;

    await Future.wait([
      _fetchArticleBriefList(),
      _fetchQuestionOverviewList(),
    ]);

    _isLoading.value = false;
  }

  Future<void> onRefresh() async {
    await Future.wait([
      _fetchArticleBriefList(),
      _fetchQuestionOverviewList(),
    ]);
  }

  Future<void> _fetchArticleBriefList() async {
    StateWrapper<List<ArticleBriefState>> state =
        await _readArticleBriefListUseCase.execute(
      ReadArticleBriefListCondition(
        page: 0,
        size: 3,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleBriefList.assignAll(state.data!);
  }

  Future<void> _fetchQuestionOverviewList() async {
    StateWrapper<List<QuestionBriefState>> state =
        await _readQuestionBriefListUseCase.execute(
      ReadQuestionBriefListCondition(
        page: 0,
        size: 3,
      ),
    );

    if (!state.success) {
      return;
    }

    _questionBriefList.assignAll(state.data!);
  }
}
