import {z} from 'zod';

export const ReadAnswerDtoSchema = z.object({
    id: z.number(),
    content: z.string(),
    createdAt: z.string(),
    nickname: z.string().optional().nullable(),
    creatorId: z.string().optional().nullable()
})

export const ReadAnswerListDtoSchema = z.object({
    answers: z.array(ReadAnswerDtoSchema)
})

export const CreateAnswerDtoSchema = z.object({
    content: z.string(),
})

export type ReadAnswerDto = z.infer<typeof ReadAnswerDtoSchema>
export type ReadAnswerListDto = z.infer<typeof ReadAnswerListDtoSchema>
export type CreateAnswerDto = z.infer<typeof CreateAnswerDtoSchema>