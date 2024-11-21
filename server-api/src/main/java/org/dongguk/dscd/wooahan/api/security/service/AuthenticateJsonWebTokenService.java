package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.repository.mysql.AccountRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.RefreshTokenRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.AuthenticateJsonWebTokenUseCase;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthenticateJsonWebTokenService implements AuthenticateJsonWebTokenUseCase {

    private final AccountRepository accountRepository;

    private final RefreshTokenRepository refreshTokenRepository;

    @Override
    public UserPrincipal execute(UUID accountId) {
        Account account = accountRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        refreshTokenRepository.findById(accountId)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_LOGIN_USER));

        return UserPrincipal.create(account);
    }
}