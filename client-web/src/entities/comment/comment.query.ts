import {queryOptions} from "@tanstack/react-query";
import {CommentService} from "./comment.service.ts";

export class CommentQuery {
    static readonly keys = {
        list: (columnId: number) => ['comment', 'list', columnId] as const
    }

    static readCommentListQuery(columnId: number) {
        return queryOptions(({
            queryKey: [...this.keys.list(columnId)],
            queryFn: async () => {
                const response = await CommentService.readCommentListQuery(columnId);
                return response.data;
            }
        }))
    }
}

export default CommentQuery;