package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateAuthenticationCodeDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.TemporaryJsonWebTokenDto;

public interface ValidateAuthenticationCodeUseCase {

    /**
     * 이메일 인증 코드 발급
     * @param requestDto 이메일 인증 요청 DTO
     * @return 이메일 인증 응답 DTO
     */
    TemporaryJsonWebTokenDto execute(ValidateAuthenticationCodeDto requestDto);
}
