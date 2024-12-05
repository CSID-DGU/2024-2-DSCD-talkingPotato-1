import { AxiosContracts, httpClient } from "@shared/lib/axios";
import {
  LoginDto,
  RegisterDto,
  ValidateAuthenticationCodeDto,
} from "./auth.types.ts";
import { LoginDtoSchema } from "./auth.contracts";

export class AuthService {
  /**
   * Login
   * @param LoginDto
   */
  static loginMutation(data: { loginDto: LoginDto }) {
    const loginDto = AxiosContracts.requestContract(
      LoginDtoSchema,
      data.loginDto
    );

    const formData = new FormData();

    formData.append("serial_id", loginDto.serialId);
    formData.append("password", loginDto.password);

    return httpClient.post(`/auth/login`, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });
  }

  /**
   * Logout
   */
  static logoutMutation() {
    return httpClient.post(`/auth/logout`);
  }

  /**
   * Withdrawal
   */
  static withdrawalMutation() {
    return httpClient.delete(`/auth/withdrawal`);
  }

  /**
   * Reissue Password
   */
  static reissuePasswordMutation() {
    return httpClient.post(`/auth/reissue/password`);
  }

  /**
   * Reissue JWT Token
   */
  static reissueJwtTokenMutation() {
    return httpClient.post(`/auth/reissue/token`);
  }

  /**
   * Validate Email
   * @param email
   */
  static validateEmailMutation(data: { email: string }) {
    return httpClient.post(`/auth/validations/email`, {
      email: data.email,
    });
  }

  /**
   * Validate Authentication Code
   * @param email
   * @param authenticationCode
   */
  static validateAuthenticationCodeMutation(
    data: ValidateAuthenticationCodeDto
  ) {
    return httpClient.post(`/auth/validations/authentication-code`, {
      email: data.email,
      authentication_code: data.code,
    });
  }

  /**
   * Register
   * @param RegisterDto
   */
  static register(data: RegisterDto, temporaryToken: string) {
    return httpClient.post(
      `/auth/sign-up`,
      {
        nickname: data.nickname,
        password: data.password,
        career: data.career,
      },
      {
        headers: {
          Authorization: `Bearer ${temporaryToken}`,
        },
      }
    );
  }
}

export default AuthService;
