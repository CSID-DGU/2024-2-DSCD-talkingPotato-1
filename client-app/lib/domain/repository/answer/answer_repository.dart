import 'package:wooahan/core/wrapper/state_wrapper.dart';
import 'package:wooahan/domain/condition/answer/read_question_answer_list_condition.dart';
import 'package:wooahan/domain/entity/answer/answer_state.dart';

abstract class AnswerRepository {
  Future<StateWrapper<List<AnswerState>>> readQuestionAnswerList(
    ReadQuestionAnswerListCondition condition,
  );
}
