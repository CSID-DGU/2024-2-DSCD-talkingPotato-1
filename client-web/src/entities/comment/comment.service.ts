import { instance } from "@shared/lib/axios";
import { AxiosContracts, AxiosResponseType } from "@shared/lib/axios";
import {
  ReadCommentDto,
  ReadCommentListDto,
  ReadCommentListDtoSchema,
} from "./comment.contracts.ts";

export class CommentService {
  static readCommentListQuery(articleId: number) {
    return instance
      .get<
        AxiosResponseType<ReadCommentListDto>
      >(`/api/v1/articles/${articleId}/comments`)
      .then(AxiosContracts.responseContract(ReadCommentListDtoSchema));
  }

  static createCommentMutation(articleId: number, comment: ReadCommentDto) {
    return instance.post<AxiosResponseType<ReadCommentDto>>(
      `/api/v1/articles/${articleId}/comments`,
      {
        comment: comment.content,
      }
    );
  }

  static deleteCommentMutation(commentId: number) {
    return instance.delete<AxiosResponseType<null>>(
      `/api/v1/comments/${commentId}`
    );
  }
}

export default CommentService;
