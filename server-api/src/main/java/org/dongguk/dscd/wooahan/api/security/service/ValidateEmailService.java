package org.dongguk.dscd.wooahan.api.security.service;

import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCode;
import org.dongguk.dscd.wooahan.api.security.domain.redis.AuthenticationCodeHistory;
import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateEmailDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.EmailAuthenticationAttemptDto;
import org.dongguk.dscd.wooahan.api.security.event.ValidateEmailEvent;
import org.dongguk.dscd.wooahan.api.security.repository.redis.AuthenticationCodeHistoryRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.AuthenticationCodeRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.ValidateEmailUseCase;
import org.dongguk.dscd.wooahan.api.security.util.RandomUtil;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ValidateEmailService implements ValidateEmailUseCase {

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final AuthenticationCodeRepository authenticationCodeRepository;
    private final AuthenticationCodeHistoryRepository authenticationCodeHistoryRepository;

    private final ApplicationEventPublisher applicationEventPublisher;

    @Override
    public EmailAuthenticationAttemptDto execute(ValidateEmailDto requestDto) {
        // 인증코드 발급 이력 조회
        AuthenticationCodeHistory history = authenticationCodeHistoryRepository.findById(requestDto.email())
                .orElse(null);

        // 인증코드 발급 제한 확인
        if (isBlockedIssuingAuthenticationCode(history)) {
            throw new CommonException(ErrorCode.TOO_MANY_AUTHENTICATION_CODE_REQUESTS);
        }

        // 인증코드 발급 속도 제한 확인(1분 이내에 재요청 했을 경우)
        if (isTooFastIssuingAuthenticationCode(history)) {
            throw new CommonException(ErrorCode.TOO_FAST_AUTHENTICATION_CODE_REQUESTS);
        }

        // 새로운 인증코드 생성
        String code = RandomUtil.generateAuthCode(6);
        AuthenticationCode authenticationCode = authenticationCodeRepository.save(
                AuthenticationCode.builder()
                        .email(requestDto.email())
                        .value(bCryptPasswordEncoder.encode(code))
                        .build()
        );

        // 인증코드 발급 이력 업데이트
        if (history == null) {
            history = authenticationCodeHistoryRepository.save(
                    AuthenticationCodeHistory.builder()
                            .email(requestDto.email())
                            .count(1)
                            .build()
            );
        } else {
            history = authenticationCodeHistoryRepository.save(history.copyWith(history.getCount() + 1));
        }

        // 메일 전송(비동기)
        applicationEventPublisher.publishEvent(ValidateEmailEvent.builder()
                .receiverAddress(requestDto.email())
                .authenticationCode(code)
                .build());

        return EmailAuthenticationAttemptDto.fromEntity(history);
    }

    /**
     * 인증코드 발급을 막은 사용자인지 확인
     * @param history 인증코드 발급 이력
     * @return 인증코드 발급을 막은 사용자인지 여부
     */
    private Boolean isBlockedIssuingAuthenticationCode(AuthenticationCodeHistory history) {
        if (history == null) {
            return false;
        }

        return history.getCount() >= 5;
    }

    /**
     * 인증코드 발급 속도가 너무 빠른지 확인
     * @param history 인증코드 발급 이력
     * @return 인증코드 발급 속도가 너무 빠른지 여부
     */
    private Boolean isTooFastIssuingAuthenticationCode(AuthenticationCodeHistory history) {
        if (history == null) {
            return false;
        }

        return history.getLastSentAt().isAfter(LocalDateTime.now().minusMinutes(1));
    }
}

