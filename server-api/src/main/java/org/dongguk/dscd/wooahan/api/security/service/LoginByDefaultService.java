package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.security.domain.redis.RefreshToken;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.repository.redis.RefreshTokenRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.LoginByDefaultUseCase;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class LoginByDefaultService implements LoginByDefaultUseCase {

    private final RefreshTokenRepository refreshTokenRepository;

    @Override
    @Transactional
    public void execute(
            UserPrincipal principal,
            DefaultJsonWebTokenDto jsonWebTokenDto
    ) {
        UUID accountId = principal.getId();
        String refreshToken = jsonWebTokenDto.refreshToken();

        if (refreshToken != null) {
            refreshTokenRepository.save(
                    RefreshToken.builder()
                            .accountId(accountId)
                            .value(refreshToken)
                            .build()
            );
        }
    }
}
