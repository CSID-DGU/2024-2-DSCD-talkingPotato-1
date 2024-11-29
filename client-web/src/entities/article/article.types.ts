import { z } from "zod";
import {
  CreateArticleDtoSchema,
  ReadArticleDetailDtoSchema,
  ReadArticleListDtoSchema,
  ReadArticleDtoSchema,
} from "./article.contracts.ts";

export type ReadArticleDetail = z.infer<typeof ReadArticleDetailDtoSchema>;
export type ReadArticleList = z.infer<typeof ReadArticleListDtoSchema>;
export type CreateArticle = z.infer<typeof CreateArticleDtoSchema>;
export type ReadArticle = z.infer<typeof ReadArticleDtoSchema>;
