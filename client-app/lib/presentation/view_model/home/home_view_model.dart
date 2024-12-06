import 'package:get/get.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/usecase/question/read_question_brief_list_by_user_use_case.dart';
import 'package:wooahan/domain/usecase/user/read_nickname_in_user_use_case.dart';

class HomeViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final ReadNicknameInUserUseCase _readNicknameInUserUseCase;

  late final ReadQuestionBriefListByUserUseCase
      _readQuestionBriefListByUserUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isInitLoading;
  late final RxBool _isMoreLoading;

  late final RxString _nickname;
  late final RxList<QuestionBriefState> _questionBriefList;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isInitLoading => _isInitLoading.value;
  bool get isMoreLoading => _isMoreLoading.value;

  String get nickname => _nickname.value;
  List<QuestionBriefState> get questionBriefList => _questionBriefList;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    _readNicknameInUserUseCase = Get.find<ReadNicknameInUserUseCase>();
    _readQuestionBriefListByUserUseCase =
        Get.find<ReadQuestionBriefListByUserUseCase>();

    _isInitLoading = true.obs;
    _isMoreLoading = false.obs;

    _nickname = "".obs;
    _questionBriefList = <QuestionBriefState>[
      QuestionBriefState.initial(),
      QuestionBriefState.initial(),
      QuestionBriefState.initial(),
    ].obs;
  }

  @override
  void onReady() async {
    super.onReady();

    await Future.wait([
      _fetchUserInformation(),
      _fetchQuestionBriefList(),
    ]);

    _isInitLoading.value = false;
  }

  Future<void> onRefresh() async {
    _isMoreLoading.value = true;

    await Future.wait([
      _fetchQuestionBriefList(),
    ]);

    _isMoreLoading.value = false;
  }

  Future<void> _fetchUserInformation() async {
    StateWrapper<String> nickname = _readNicknameInUserUseCase.execute();

    _nickname.value = nickname.data!;
  }

  Future<void> _fetchQuestionBriefList() async {
    StateWrapper<List<QuestionBriefState>> questionBriefList =
        await _readQuestionBriefListByUserUseCase.execute();

    _questionBriefList.assignAll(questionBriefList.data!);
  }
}
