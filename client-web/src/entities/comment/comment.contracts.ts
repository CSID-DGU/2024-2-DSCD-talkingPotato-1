import {z} from 'zod'

export const ReadCommentDtoSchema = z.object({
    id: z.number(),
    nickname: z.string(),
    content: z.string(),
    createdAt: z.string(),
    creatorId: z.string()
})

export const ReadCommentListDtoSchema = z.object({
    comments: z.array(ReadCommentDtoSchema)
})

export const CreateCommentDtoSchema = z.object({
    content: z.string(),
})

export type ReadCommentDto = z.infer<typeof ReadCommentDtoSchema>
export type ReadCommentListDto = z.infer<typeof ReadCommentListDtoSchema>
export type CreateCommentDto = z.infer<typeof CreateCommentDtoSchema>