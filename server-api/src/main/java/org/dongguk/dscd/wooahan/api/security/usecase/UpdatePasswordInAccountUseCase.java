package org.dongguk.dscd.wooahan.api.security.usecase;

import org.dongguk.dscd.wooahan.api.security.dto.request.UpdatePasswordInAccountDto;

import java.util.UUID;

public interface UpdatePasswordInAccountUseCase {

    /**
     * 계정 비밀번호 수정
     * @param accountId 계정 아이디
     * @param requestDto 계정 비밀번호 수정 DTO
     */
    void execute(
            UUID accountId,
            UpdatePasswordInAccountDto requestDto
    );
}
