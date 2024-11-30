package org.dongguk.dscd.wooahan.api.user.usecase;

import org.dongguk.dscd.wooahan.api.user.dto.response.ReadUserDto;

import java.util.UUID;

public interface ReadUserUseCase {
    /**
     * 사용자 조회
     * @param accountId 계정 ID
     */
    ReadUserDto execute(UUID accountId);
}
