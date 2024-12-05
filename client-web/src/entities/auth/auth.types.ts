import { z } from "zod";
import {
  LoginDtoSchema,
  RegisterDtoSchema,
  ValidateAuthenticationCodeDtoSchema,
  ValidateEmailDtoSchema,
} from "./auth.contracts.ts";

export type LoginDto = z.infer<typeof LoginDtoSchema>;
export type RegisterDto = z.infer<typeof RegisterDtoSchema>;
export type ValidateAuthenticationCodeDto = z.infer<
  typeof ValidateAuthenticationCodeDtoSchema
>;
export type ValidateEmailDto = z.infer<typeof ValidateEmailDtoSchema>;
