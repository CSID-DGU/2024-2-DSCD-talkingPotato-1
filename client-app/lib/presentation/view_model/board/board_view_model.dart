import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/article/read_article_brief_list_condition.dart';
import 'package:wooahan/domain/entity/article/article_brief_state.dart';
import 'package:wooahan/domain/entity/question/question_overview_state.dart';
import 'package:wooahan/domain/usecase/article/read_article_brief_list_use_case.dart';

class BoardViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadArticleBriefListUseCase _readArticleBriefListUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;
  late final RxList<ArticleBriefState> _articleBriefList;
  late final RxList<QuestionOverviewState> _questionOverviewList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */

  bool get isLoading => _isLoading.value;
  List<ArticleBriefState> get articleBriefList => _articleBriefList;
  List<QuestionOverviewState> get questionOverviewList => _questionOverviewList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readArticleBriefListUseCase = Get.find<ReadArticleBriefListUseCase>();

    _isLoading = true.obs;
    _articleBriefList = <ArticleBriefState>[].obs;
    _questionOverviewList = <QuestionOverviewState>[].obs;
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

  Future<void> _fetchArticleBriefList() async {
    StateWrapper<List<ArticleBriefState>> state =
        await _readArticleBriefListUseCase.execute(
      ReadArticleBriefListCondition(
        page: 1,
        size: 3,
      ),
    );

    if (!state.success) {
      return;
    }

    _articleBriefList.assignAll(state.data!);
  }

  Future<void> _fetchQuestionOverviewList() async {
    // List<QuestionOverviewState> questionOverviewList = [
    //   QuestionOverviewState(
    //     id: 1,
    //     title: '질문 제목',
    //     content: '질문 내용',
    //     answerCount: 3,
    //     createdAt: DateTime.now(),
    //   ),
    //   QuestionOverviewState(
    //     id: 2,
    //     title: '질문 제목',
    //     content: '질문 내용',
    //     answerCount: 3,
    //     createdAt: DateTime.now(),
    //   ),
    //   QuestionOverviewState(
    //     id: 3,
    //     title: '질문 제목',
    //     content: '질문 내용',
    //     answerCount: 3,
    //     createdAt: DateTime.now(),
    //   ),
    // ];
    //
    // _questionOverviewList.assignAll(questionOverviewList);
  }
}
