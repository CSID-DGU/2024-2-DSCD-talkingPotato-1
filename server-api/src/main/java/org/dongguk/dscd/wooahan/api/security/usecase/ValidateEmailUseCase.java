package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateEmailDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.EmailAuthenticationAttemptDto;

public interface ValidateEmailUseCase {

    /**
     * 이메일 인증 코드 발급
     * @param requestDto 이메일 인증 요청 DTO
     * @return 이메일 인증 응답 DTO
     */
    EmailAuthenticationAttemptDto execute(ValidateEmailDto requestDto);
}
