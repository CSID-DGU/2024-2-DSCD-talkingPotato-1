import 'package:get/get.dart';
import 'package:wooahan/core/mediator/base_mediator.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/usecase/comment/create_article_comment_use_case.dart';

class CommentAddingViewModel extends GetxController {
  /* ------------------------------------------------------ */
  /* DI Fields -------------------------------------------- */
  /* ------------------------------------------------------ */
  late final int articleId;

  late final CreateArticleCommentUseCase _createArticleCommentUseCase;

  /* ------------------------------------------------------ */
  /* Private Fields --------------------------------------- */
  /* ------------------------------------------------------ */
  late final RxBool _isLoading;
  late final RxString _content;

  /* ------------------------------------------------------ */
  /* Public Fields ---------------------------------------- */
  /* ------------------------------------------------------ */
  bool get isLoading => _isLoading.value;
  String get content => _content.value;

  /* ------------------------------------------------------ */
  /* Method ----------------------------------------------- */
  /* ------------------------------------------------------ */
  @override
  void onInit() {
    super.onInit();

    articleId = Get.arguments['id'];

    _createArticleCommentUseCase = Get.find<CreateArticleCommentUseCase>();

    _isLoading = false.obs;
    _content = ''.obs;
  }

  void updateContent(String value) {
    _content.value = value;
  }

  Future<bool> createComment() async {
    _isLoading.value = true;

    StateWrapper<void> result = await _createArticleCommentUseCase.execute(
      CreateArticleCommentCondition(
        articleId: articleId,
        content: _content.value,
        isMadeByStt: false,
      ),
    );

    await Get.find<BaseMediator>().publishCreateArticleCommentEvent(articleId);

    _isLoading.value = false;

    return result.success;
  }
}
