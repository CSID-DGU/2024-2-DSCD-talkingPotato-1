import { z } from "zod";

export const ReadArticleDetailDtoSchema = z.object({
  id: z.number(),
  title: z.string(),
  content: z.string(),
  tags: z.array(z.string()),
  createdAt: z.string(),
  commentCnt: z.number(),
  nickname: z.string(),
  creatorId: z.string(),
});

export const ReadArticleDtoSchema = z.object({
  id: z.number(),
  title: z.string(),
  preview: z.string(),
  tags: z.array(z.string()),
  createdAt: z.string(),
  commentCnt: z.number(),
  nickname: z.string(),
  creatorId: z.string(),
});

export const ReadArticleListDtoSchema = z.object({
  articles: z.array(ReadArticleDtoSchema),
});

export const CreateArticleDtoSchema = z.object({
  title: z.string(),
  content: z.string(),
  tags: z.array(z.string()),
});

export type ReadArticleDetailDto = z.infer<typeof ReadArticleDetailDtoSchema>;
export type ReadArticleDto = z.infer<typeof ReadArticleDtoSchema>;
export type ReadArticleListDto = z.infer<typeof ReadArticleListDtoSchema>;
export type CreateArticleDto = z.infer<typeof CreateArticleDtoSchema>;
