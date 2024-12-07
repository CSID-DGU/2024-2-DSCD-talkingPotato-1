import 'package:get/get.dart';
import 'package:wooahan/core/usecase/async_condition_usecase.dart';
import 'package:wooahan/core/usecase/common/base_use_case.dart';
import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/comment/create_article_comment_condition.dart';
import 'package:wooahan/domain/condition/correction/correct_speech_text_condition.dart';
import 'package:wooahan/domain/repository/comment/comment_repository.dart';
import 'package:wooahan/domain/repository/correction/correction_repository.dart';

class CreateArticleCommentUseCase extends BaseUseCase
    implements AsyncConditionUseCase<void, CreateArticleCommentCondition> {
  late final CorrectionRepository _correctionRepository;
  late final CommentRepository _commentRepository;

  @override
  void onInit() {
    super.onInit();

    _correctionRepository = Get.find<CorrectionRepository>();
    _commentRepository = Get.find<CommentRepository>();
  }

  @override
  Future<StateWrapper<void>> execute(
    CreateArticleCommentCondition condition,
  ) async {
    String content = condition.content;

    if (condition.isMadeByStt) {
      StateWrapper<String> correctContentWrapper =
          await _correctionRepository.correctSpeechText(
        CorrectSpeechTextCondition(
          content: content,
        ),
      );

      content = correctContentWrapper.data ?? content;
    }

    return await _commentRepository.createArticleComment(
      CreateArticleCommentCondition(
        articleId: condition.articleId,
        content: content,
        isMadeByStt: condition.isMadeByStt,
      ),
    );
  }
}
