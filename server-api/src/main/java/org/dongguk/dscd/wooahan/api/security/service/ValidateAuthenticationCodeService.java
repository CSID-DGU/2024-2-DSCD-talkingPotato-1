package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCode;
import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCodeHistory;
import org.dongguk.dscd.wooahan.api.security.domain.redis.TemporaryToken;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateAuthenticationCodeDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.TemporaryJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.repository.redis.AuthenticationCodeHistoryRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.AuthenticationCodeRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.TemporaryTokenRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.ValidateAuthenticationCodeUseCase;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ValidateAuthenticationCodeService implements ValidateAuthenticationCodeUseCase {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final AuthenticationCodeRepository authenticationCodeRepository;
    private final AuthenticationCodeHistoryRepository authenticationCodeHistoryRepository;
    private final TemporaryTokenRepository temporaryTokenRepository;

    private final JsonWebTokenUtil jsonWebTokenUtil;

    @Override
    public TemporaryJsonWebTokenDto execute(ValidateAuthenticationCodeDto requestDto) {
        AuthenticationCode authenticationCode = authenticationCodeRepository.findById(requestDto.email())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_RESOURCE));

        AuthenticationCodeHistory authenticationCodeHistory = authenticationCodeHistoryRepository.findById(requestDto.email())
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_RESOURCE));

        if (!bCryptPasswordEncoder.matches(requestDto.authenticationCode(), authenticationCode.getValue())) {
            throw new CommonException(ErrorCode.ACCESS_DENIED);
        }

        authenticationCodeRepository.delete(authenticationCode);
        authenticationCodeHistoryRepository.delete(authenticationCodeHistory);

        TemporaryJsonWebTokenDto temporaryTokenDto = jsonWebTokenUtil.generateTemporaryJsonWebToken(
                requestDto.email(),
                EProvider.DEFAULT
        );

        temporaryTokenRepository.save(TemporaryToken.builder()
                .email(requestDto.email())
                .value(temporaryTokenDto.temporaryToken())
                .build()
        );

        return temporaryTokenDto;
    }
}
