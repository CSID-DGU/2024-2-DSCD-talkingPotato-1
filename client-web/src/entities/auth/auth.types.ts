import {z} from 'zod';
import {LoginDtoSchema, RegisterDtoSchema} from "./auth.contracts.ts";

export type LoginDto = z.infer<typeof LoginDtoSchema>;
export type RegisterDto = z.infer<typeof RegisterDtoSchema>;