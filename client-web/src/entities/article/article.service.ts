import { AxiosContracts, AxiosResponseType, instance } from "@shared/lib/axios";
import {
  CreateArticle,
  ReadArticle,
  ReadArticleList,
} from "./article.types.ts";
import {
  ReadArticleDetailDtoSchema,
  ReadArticleListDtoSchema,
} from "./article.contracts.ts";

export class ArticleService {
  static readArticleListQuery() {
    return instance
      .get<AxiosResponseType<ReadArticleList>>(`/api/v1/articles`)
      .then(AxiosContracts.responseContract(ReadArticleListDtoSchema));
  }

  static readArticleQuery(id: number) {
    return instance
      .get<AxiosResponseType<ReadArticle>>(`/api/v1/articles/${id}`)
      .then(AxiosContracts.responseContract(ReadArticleDetailDtoSchema));
  }

  static createArticleMutation(article: CreateArticle) {
    return instance.post<AxiosResponseType<null>>(`/api/v1/articles`, {
      title: article.title,
      content: article.content,
      tags: article.tags,
    });
  }

  static updateArticleMutation(columnId: number, article: CreateArticle) {
    return instance.put<AxiosResponseType<null>>(
      `/api/v1/articles/${columnId}`,
      {
        title: article.title,
        content: article.content,
        tags: article.tags,
      }
    );
  }

  static deleteArticleMutation(columnId: number) {
    return instance.delete<AxiosResponseType<null>>(
      `/api/v1/articles/${columnId}`
    );
  }
}

export default ArticleService;
