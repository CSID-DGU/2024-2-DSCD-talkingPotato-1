import { z } from "zod";
import {
  ReadQuestionDetailDtoSchema,
  ReadQuestionDtoSchema,
  ReadQuestionListDtoSchema,
} from "./question.contracts.ts";

export type ReadQuestionDetail = z.infer<typeof ReadQuestionDetailDtoSchema>;
export type ReadQuestionList = z.infer<typeof ReadQuestionListDtoSchema>;
export type ReadQuestion = z.infer<typeof ReadQuestionDtoSchema>;
