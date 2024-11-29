import {z} from 'zod';

export const LoginDtoSchema = z.object({
    serialId: z.string().email({
        message: '이메일 형식이 올바르지 않습니다.',
    }),
    password: z
        .string()
        .regex(
            /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$/,
            {
                message:
                    '비밀번호는 영문, 숫자, 특수문자를 포함하여 8-20자리여야 합니다.',
            },
        ),
})

export const RegisterDtoSchema = z.object({
    nickname: z.string(),
    password: z.string().max(20),
    career: z.string().max(1000).optional()
});