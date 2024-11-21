package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;

public interface ReissueJsonWebTokenUseCase {

    /**
     * Refresh Token을 이용하여 새로운 JsonWebToken을 발급하는 유스케이스
     * @param refreshToken Refresh Token
     * @return DefaultJsonWebTokenDto
     */
    DefaultJsonWebTokenDto execute(String refreshToken);
}
