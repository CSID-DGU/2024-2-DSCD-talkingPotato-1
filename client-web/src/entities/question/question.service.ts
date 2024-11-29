import {
  ReadQuestionDetailDto,
  ReadQuestionDetailDtoSchema,
  ReadQuestionListDto,
  ReadQuestionListDtoSchema,
} from "./question.contracts.ts";
import { AxiosContracts, AxiosResponseType, instance } from "@shared/lib/axios";

export class QuestionService {
  static readQuestionListQuery() {
    return instance
      .get<AxiosResponseType<ReadQuestionListDto>>(`/api/v1/questions`)
      .then(AxiosContracts.responseContract(ReadQuestionListDtoSchema));
  }

  static readQuestionQuery(questionId: number) {
    return instance
      .get<
        AxiosResponseType<ReadQuestionDetailDto>
      >(`/api/v1/questions/${questionId}`)
      .then(AxiosContracts.responseContract(ReadQuestionDetailDtoSchema));
  }
}

export default QuestionService;
