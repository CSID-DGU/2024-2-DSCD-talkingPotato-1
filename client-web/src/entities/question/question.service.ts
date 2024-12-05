import {
  ReadQuestionDetailDto,
  ReadQuestionDetailDtoSchema,
  ReadQuestionListDto,
  ReadQuestionListDtoSchema,
} from "./question.contracts.ts";
import {
  AxiosContracts,
  AxiosResponseType,
  httpClient,
} from "@shared/lib/axios";

export class QuestionService {
  static readQuestionListQuery(searchTerm?: string) {
    let baseUrl = `/api/v1/questions?page=0&size=1000`;

    if (searchTerm && searchTerm.length > 1) {
      baseUrl += `&q=${searchTerm}`;
    }

    return httpClient
      .get<AxiosResponseType<ReadQuestionListDto>>(baseUrl)
      .then(AxiosContracts.responseContract(ReadQuestionListDtoSchema));
  }

  static readQuestionQuery(questionId: number) {
    return httpClient
      .get<
        AxiosResponseType<ReadQuestionDetailDto>
      >(`/api/v1/questions/${questionId}`)
      .then(AxiosContracts.responseContract(ReadQuestionDetailDtoSchema));
  }
}

export default QuestionService;
