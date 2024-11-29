import QuestionService from "./question.service.ts";
import {queryOptions} from "@tanstack/react-query";

export class QuestionQueries {
    static readonly keys = {
        list: ['question', 'list'] as const,
        detail: (id: number) => ['question', 'detail', id] as const,
    }

    static readQuestionListQuery() {
        return queryOptions({
            queryKey: [...this.keys.list],
            queryFn: async () => {
                const response = await QuestionService.readQuestionListQuery();
                return response.data;
            }
        })
    }

    static readQuestionDetailQuery(id: number) {
        return queryOptions({
            queryKey: [...this.keys.detail(id)],
            queryFn: async () => {
                const response = await QuestionService.readQuestionQuery(id);
                return response.data;
            }
        })
    }
}

export default QuestionQueries;