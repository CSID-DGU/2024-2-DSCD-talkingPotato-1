import { z } from "zod";

export const ReadQuestionDetailDtoSchema = z.object({
  id: z.number(),
  content: z.string(),
  createdAt: z.string(),
  answerCount: z.number(),
  nickname: z.string(),
  creatorId: z.string(),
});

export const ReadQuestionDtoSchema = z.object({
  id: z.number(),
  preview: z.string(),
  answerStatus: z.string(),
  createdAt: z.string(),
  answerCount: z.number(),
  nickname: z.string(),
  creatorId: z.string(),
});

export const ReadQuestionListDtoSchema = z.object({
  questions: z.array(ReadQuestionDtoSchema),
});

export type ReadQuestionDetailDto = z.infer<typeof ReadQuestionDetailDtoSchema>;
export type ReadQuestionDto = z.infer<typeof ReadQuestionDtoSchema>;
export type ReadQuestionListDto = z.infer<typeof ReadQuestionListDtoSchema>;
