package org.dongguk.dscd.wooahan.api.user.usecase;

import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserDeviceTokenDto;

import java.util.UUID;

public interface UpdateUserDeviceTokenUseCase {
    /**
     * 사용자 알림 시간 수정
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     */
    void execute(
            UUID accountId,
            UpdateUserDeviceTokenDto requestDto
    );

}
