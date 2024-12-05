import {z} from "zod";
import {CreateAnswerDtoSchema, ReadAnswerDtoSchema, ReadAnswerListDtoSchema} from "./answer.contracts";

export type ReadAnswer = z.infer<typeof ReadAnswerDtoSchema>;
export type ReadAnswerList = z.infer<typeof ReadAnswerListDtoSchema>;
export type CreateAnswer = z.infer<typeof CreateAnswerDtoSchema>;