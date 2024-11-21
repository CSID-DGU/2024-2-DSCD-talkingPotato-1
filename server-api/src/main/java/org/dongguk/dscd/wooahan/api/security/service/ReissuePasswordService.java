package org.dongguk.dscd.wooahan.api.security.service;

import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.mysql.Account;
import org.dongguk.dscd.wooahan.api.security.domain.redis.TemporaryToken;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.event.ReissuePasswordEvent;
import org.dongguk.dscd.wooahan.api.security.repository.mysql.AccountRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.TemporaryTokenRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.ReissuePasswordUseCase;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.dongguk.dscd.wooahan.api.security.util.RandomUtil;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ReissuePasswordService implements ReissuePasswordUseCase {

    private final AccountRepository accountRepository;

    private final TemporaryTokenRepository temporaryTokenRepository;

    private final JsonWebTokenUtil jsonWebTokenUtil;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final ApplicationEventPublisher applicationEventPublisher;

    @Override
    @Transactional
    public void execute(String temporaryToken) {
        // Temporary Token 검증
        Claims claims = jsonWebTokenUtil.validateToken(temporaryToken);

        // Serial Email 추출
        String serialEmail = claims.get(Constants.ACCOUNT_ID_CLAIM_NAME, String.class);

        // Temporary Token 존재 여부 확인
        if (!isEqualsTemporaryToken(serialEmail, temporaryToken)) {
            throw new CommonException(ErrorCode.TOKEN_INVALID_ERROR);
        }

        // 계정 조회
        Account account = accountRepository.findBySerialIdAndProvider(serialEmail, EProvider.DEFAULT)
                .orElseThrow(() -> new CommonException(ErrorCode.NOT_FOUND_USER));

        // 임시 비밀번호 생성 및 저장
        String temporaryPassword = RandomUtil.generatePassword(8);
        account.updatePassword(bCryptPasswordEncoder.encode(temporaryPassword));

        // 메일 전송(비동기)
        applicationEventPublisher.publishEvent(ReissuePasswordEvent.builder()
                .receiverAddress(serialEmail)
                .temporaryPassword(temporaryPassword)
                .build()
        );
    }

    /**
     * Temporary Token 일치 여부 확인
     *
     * @param serialEmail    Account ID
     * @param temporaryToken Refresh Token
     * @return Redis에 저장된 Temporary Token과 일치 여부
     */
    private Boolean isEqualsTemporaryToken(String serialEmail, String temporaryToken) {
        TemporaryToken temporaryTokenEntity = temporaryTokenRepository.findById(serialEmail)
                .orElseThrow(() -> new CommonException(ErrorCode.TOKEN_INVALID_ERROR));

        return temporaryTokenEntity.getValue().equals(temporaryToken);
    }
}
