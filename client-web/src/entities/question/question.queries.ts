import QuestionService from "./question.service.ts";
import { queryOptions } from "@tanstack/react-query";

export class QuestionQueries {
  static readonly keys = {
    list: ["question", "list"] as const,
    detail: (id: number) => ["question", "detail", id] as const,
  };

  static readQuestionListQuery(searchTerm?: string) {
    return queryOptions({
      queryKey: [...this.keys.list, searchTerm],
      queryFn: async () => {
        const response =
          await QuestionService.readQuestionListQuery(searchTerm);
        return response.data;
      },
    });
  }

  static readQuestionDetailQuery(id: number) {
    return queryOptions({
      queryKey: [...this.keys.detail(id)],
      queryFn: async () => {
        const response = await QuestionService.readQuestionQuery(id);
        return response.data;
      },
    });
  }
}

export default QuestionQueries;
