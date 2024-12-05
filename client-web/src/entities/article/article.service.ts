import {
  AxiosContracts,
  AxiosResponseType,
  httpClient,
} from "@shared/lib/axios";
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
  static readArticleListQuery(searchTerm?: string) {
    let baseUrl = `/api/v1/articles?page=0&size=1000`;

    if (searchTerm && searchTerm.length > 1) {
      baseUrl += `&q=${searchTerm}`;
    }

    return httpClient
      .get<AxiosResponseType<ReadArticleList>>(baseUrl)
      .then(AxiosContracts.responseContract(ReadArticleListDtoSchema));
  }

  static readArticleQuery(id: number) {
    return httpClient
      .get<AxiosResponseType<ReadArticle>>(`/api/v1/articles/${id}`)
      .then(AxiosContracts.responseContract(ReadArticleDetailDtoSchema));
  }

  static createArticleMutation(article: CreateArticle) {
    return httpClient.post<AxiosResponseType<null>>(`/api/v1/articles`, {
      title: article.title,
      content: article.content,
      tags: article.tags,
    });
  }

  static updateArticleMutation(articleId: number, article: CreateArticle) {
    return httpClient.put<AxiosResponseType<null>>(
      `/api/v1/articles/${articleId}`,
      {
        title: article.title,
        content: article.content,
        tags: article.tags,
      }
    );
  }

  static deleteArticleMutation(articleId: number) {
    return httpClient.delete<AxiosResponseType<null>>(
      `/api/v1/articles/${articleId}`
    );
  }
}

export default ArticleService;
