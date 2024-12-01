package org.dongguk.dscd.wooahan.api.user.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.user.dto.request.UpdateUserNotificationTimeDto;
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
}
