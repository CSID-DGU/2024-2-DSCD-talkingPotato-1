import {z} from "zod";
import {CreateCommentDtoSchema, ReadCommentDtoSchema, ReadCommentListDtoSchema} from "./comment.contracts";

export type ReadCommentList = z.infer<typeof ReadCommentListDtoSchema>;
export type ReadComment = z.infer<typeof ReadCommentDtoSchema>;
export type CreateComment = z.infer<typeof CreateCommentDtoSchema>;