import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/question/create_question_condition.dart';
import 'package:wooahan/domain/condition/question/delete_question_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_brief_list_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_detail_condition.dart';
import 'package:wooahan/domain/condition/question/read_question_summary_list_condition.dart';
import 'package:wooahan/domain/entity/question/question_brief_state.dart';
import 'package:wooahan/domain/entity/question/question_detail_state.dart';
import 'package:wooahan/domain/entity/question/question_summary_state.dart';

abstract class QuestionRepository {
  Future<StateWrapper<List<QuestionBriefState>>> readQuestionBriefList(
    ReadQuestionBriefListCondition condition,
  );

  Future<StateWrapper<List<QuestionSummaryState>>> readQuestionSummaryList(
    ReadQuestionSummaryListCondition condition,
  );

  Future<StateWrapper<QuestionDetailState>> readQuestionDetail(
    ReadQuestionDetailCondition condition,
  );

  Future<StateWrapper<List<QuestionBriefState>>> readQuestionBriefListByUser();

  Future<StateWrapper<void>> createQuestion(
    CreateQuestionCondition condition,
  );

  Future<StateWrapper<void>> deleteQuestion(
    DeleteQuestionCondition condition,
  );
}
