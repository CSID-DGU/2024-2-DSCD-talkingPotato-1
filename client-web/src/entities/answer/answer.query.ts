import {queryOptions} from "@tanstack/react-query";
import {AnswerService} from "./answer.service.ts";

export class AnswerQuery {
    static readonly keys = {
        list: (questionId: number) => ['answer', 'list', questionId] as const
    }

    static readAnswerListQuery(questionId: number) {
        return queryOptions({
            queryKey: [...this.keys.list(questionId)],
            queryFn: async () => {
                const response = await AnswerService.readAnswerListQuery(questionId);
                return response.data;
            }
        })
    }
}

export default AnswerQuery;