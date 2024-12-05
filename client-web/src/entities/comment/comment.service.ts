import { httpClient } from "@shared/lib/axios";
import { AxiosContracts, AxiosResponseType } from "@shared/lib/axios";
import {
  CreateCommentDto,
  ReadCommentDto,
  ReadCommentListDto,
  ReadCommentListDtoSchema,
} from "./comment.contracts.ts";

export class CommentService {
  static readCommentListQuery(articleId: number) {
    return httpClient
      .get<
        AxiosResponseType<ReadCommentListDto>
      >(`/api/v1/articles/${articleId}/comments`)
      .then(AxiosContracts.responseContract(ReadCommentListDtoSchema));
  }

  static createCommentMutation(articleId: number, comment: CreateCommentDto) {
    return httpClient.post<AxiosResponseType<ReadCommentDto>>(
      `/api/v1/articles/${articleId}/comments`,
      {
        content: comment.content,
      }
    );
  }

  static deleteCommentMutation(commentId: number) {
    return httpClient.delete<AxiosResponseType<null>>(
      `/api/v1/comments/${commentId}`
    );
  }
}

export default CommentService;
