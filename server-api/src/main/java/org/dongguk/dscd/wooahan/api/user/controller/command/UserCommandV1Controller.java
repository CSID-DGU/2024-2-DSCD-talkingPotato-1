package org.dongguk.dscd.wooahan.api.user.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserDeviceTokenDto;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserNotificationStatusDto;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserNotificationTimeDto;
import org.dongguk.dscd.wooahan.api.user.usecase.UpdateUserDeviceTokenUseCase;
import org.dongguk.dscd.wooahan.api.user.usecase.UpdateUserNotificationStatusUseCase;
import org.dongguk.dscd.wooahan.api.user.usecase.UpdateUserNotificationTimeUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/users")
public class UserCommandV1Controller {

    private final UpdateUserNotificationTimeUseCase updateUserNotificationTimeUseCase;
    private final UpdateUserNotificationStatusUseCase updateUserNotificationStatusUseCase;
    private final UpdateUserDeviceTokenUseCase updateUserDeviceTokenUseCase;

    /**
     * 4-2. 사용자 알림 시간 수정
     *
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PutMapping("/notification-time")
    public ResponseDto<?> updateUserNotificationTime(
            @AccountID UUID accountId,
            @RequestBody @Valid UpdateUserNotificationTimeDto requestDto
    ) {
        updateUserNotificationTimeUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 4-3. 사용자 알림 상태 수정
     *
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PutMapping("/notification-status")
    public ResponseDto<?> updateUserNotificationTime(
            @AccountID UUID accountId,
            @RequestBody @Valid UpdateUserNotificationStatusDto requestDto
    ) {
        updateUserNotificationStatusUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }

    /**
     * 4-4. 사용자 기기 토큰 수정
     *
     * @param accountId 계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasRole('USER')")
    @PutMapping("/device-token")
    public ResponseDto<?> updateUserNotificationTime(
            @AccountID UUID accountId,
            @RequestBody @Valid UpdateUserDeviceTokenDto requestDto
    ) {
        updateUserDeviceTokenUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }
}
