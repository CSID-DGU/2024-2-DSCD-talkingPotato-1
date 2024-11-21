package org.dongguk.dscd.wooahan.api.security.usecase;

import java.util.UUID;

public interface WithdrawalUseCase {
    /**
     * 회원탈퇴 요청을 처리하는 UseCase
     * @param accountId 회원탈퇴 요청을 하는 계정의 ID
     */
    void execute(UUID accountId);
}
