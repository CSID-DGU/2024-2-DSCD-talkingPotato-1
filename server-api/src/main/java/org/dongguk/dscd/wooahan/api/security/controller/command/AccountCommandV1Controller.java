package org.dongguk.dscd.wooahan.api.security.controller.command;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.security.dto.request.UpdatePasswordInAccountDto;
import org.dongguk.dscd.wooahan.api.security.usecase.UpdatePasswordInAccountUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/accounts")
public class AccountCommandV1Controller {

    private final UpdatePasswordInAccountUseCase updatePasswordInAccountUseCase;

    /**
     * 3-1. 비밀번호 수정
     *
     * @param accountId  계정 ID
     * @param requestDto 요청 DTO
     * @return 응답 DTO
     */
    @PreAuthorize("hasAnyRole('USER', 'EXPERT', 'ADMIN')")
    @PutMapping("/password")
    public ResponseDto<?> updatePassword(
            @AccountID UUID accountId,
            @RequestBody @Valid UpdatePasswordInAccountDto requestDto
    ) {
        updatePasswordInAccountUseCase.execute(accountId, requestDto);

        return ResponseDto.ok(null);
    }
}
