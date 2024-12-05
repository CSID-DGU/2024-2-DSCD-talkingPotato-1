import {
  CreateAnswerDto,
  ReadAnswerListDto,
  ReadAnswerListDtoSchema,
} from "./answer.contracts.ts";
import {
  AxiosContracts,
  AxiosResponseType,
  httpClient,
} from "@shared/lib/axios";

export class AnswerService {
  static readAnswerListQuery(questionId: number) {
    return httpClient
      .get<
        AxiosResponseType<ReadAnswerListDto>
      >(`/api/v1/questions/${questionId}/answers`)
      .then(AxiosContracts.responseContract(ReadAnswerListDtoSchema));
  }

  static createAnswerMutation(questionId: number, answer: CreateAnswerDto) {
    return httpClient.post<AxiosResponseType<null>>(
      `/api/v1/questions/${questionId}/answers`,
      {
        content: answer.content,
      }
    );
  }

  static deleteAnswerMutation(answerId: number) {
    return httpClient.delete<AxiosResponseType<null>>(
      `/api/v1/answers/${answerId}`
    );
  }
}

export default AnswerService;
