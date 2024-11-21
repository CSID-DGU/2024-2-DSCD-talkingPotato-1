package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.request.SignUpByDefaultDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;

public interface SignUpByDefaultUseCase {

    /**
     * 기본 로그인 전용 회원가입 유스케이스
     * @param temporaryToken 임시 토큰
     * @param requestDto 기본 회원가입 요청 DTO
     * @return DefaultJsonWebTokenDto
     */
    DefaultJsonWebTokenDto execute(
            String role,
            String temporaryToken,
            SignUpByDefaultDto requestDto
    );
}
