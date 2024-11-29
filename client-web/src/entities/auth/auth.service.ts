import {AxiosContracts, instance} from "@shared/lib/axios";
import {LoginDto, RegisterDto} from "./auth.types.ts";
import {LoginDtoSchema} from "./auth.contracts.ts";

export class AuthService {

    static loginMutation(data: { loginDto: LoginDto }) {

        const loginDto = AxiosContracts.requestContract(
            LoginDtoSchema,
            data.loginDto
        )

        const formData = new FormData();

        formData.append('serial_id', loginDto.serialId);
        formData.append('password', loginDto.password);

        return instance
            .post(`/auth/login`, formData)
            .then(AxiosContracts.responseContract(LoginDtoSchema))
            ;
    }

    static logoutMutation() {
        return instance.post(`/auth/logout`);
    }

    static withdrawalMutation() {
        return instance.delete(`/auth/withdrawal`);
    }

    static reissuePasswordMutation() {
        return instance.post(`/auth/reissue/password`);
    }

    static reissueJwtTokenMutation() {
        return instance.post(`/auth/reissue/token`);
    }

    static validateEmailMutation(data: { email: string }) {
        return instance.post(`/auth/validations/email`, {
            email: data.email
        });
    }

    static validateAuthenticationCodeMutation(data: {
        email: string,
        authenticationCode: string
    }) {
        return instance.post(`/auth/validations/authentication-code`, {
            email: data.email,
            authentication_code: data.authenticationCode
        });
    }

    static register(data: RegisterDto) {

        return instance.post(`/auth/sign-up`, {
            nickname: data.nickname,
            password: data.password,
            career: data.career
        });
    }
}

export default AuthService;