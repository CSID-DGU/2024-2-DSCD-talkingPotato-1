package org.dongguk.dscd.wooahan.api.user.controller.query;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.user.usecase.ReadUserUseCase;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/users")
public class UserQueryV1Controller {

    private final ReadUserUseCase readUserUseCase;

    /**
     * 4-1. 사용자 조회
     *
     * @param accountId 계정 ID
     * @return 응답 Dto
     */
    @PreAuthorize("hasRole('USER')")
    @GetMapping
    public ResponseDto<?> readUser(@AccountID UUID accountId) {
        return ResponseDto.ok(readUserUseCase.execute(accountId));
    }

}
