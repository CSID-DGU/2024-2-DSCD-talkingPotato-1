package org.dongguk.dscd.wooahan.api.security.service;

import io.jsonwebtoken.Claims;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.expert.domain.mysql.Expert;
import org.dongguk.dscd.wooahan.api.expert.repository.ExpertRepository;
import org.dongguk.dscd.wooahan.api.security.domain.redis.RefreshToken;
import org.dongguk.dscd.wooahan.api.security.domain.redis.TemporaryToken;
import org.dongguk.dscd.wooahan.api.security.domain.type.EProvider;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.security.dto.request.SignUpByDefaultDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.repository.mysql.AccountRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.RefreshTokenRepository;
import org.dongguk.dscd.wooahan.api.security.repository.redis.TemporaryTokenRepository;
import org.dongguk.dscd.wooahan.api.security.usecase.SignUpByDefaultUseCase;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.dongguk.dscd.wooahan.api.user.domain.mysql.User;
import org.dongguk.dscd.wooahan.api.user.repository.mysql.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@RequiredArgsConstructor
public class SignUpByDefaultService  implements SignUpByDefaultUseCase {

    private final AccountRepository accountRepository;
    private final UserRepository userRepository;
    private final ExpertRepository expertRepository;

    private final TemporaryTokenRepository temporaryTokenRepository;
    private final RefreshTokenRepository refreshTokenRepository;

    private final JsonWebTokenUtil jsonWebTokenUtil;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    @Override
    @Transactional
    public DefaultJsonWebTokenDto execute(
            String role,
            String temporaryToken,
            SignUpByDefaultDto requestDto
    ) {
        // Temporary Token 검증
        Claims claims = jsonWebTokenUtil.validateToken(temporaryToken);

        // Serial Email 추출
        String serialId = claims.get(Constants.ACCOUNT_ID_CLAIM_NAME, String.class);
        EProvider provider = EProvider.fromString(claims.get(Constants.PROVIDER_CLAIM_NAME, String.class));

        // Temporary Token 존재 여부 확인
        if (!isEqualsTemporaryToken(serialId, temporaryToken)) {
            throw new CommonException(ErrorCode.TOKEN_INVALID_ERROR);
        }

        // 이메일 중복 검사
        if (isDuplicatedEmail(serialId)) {
            throw new CommonException(ErrorCode.DUPLICATED_RESOURCE);
        }

        // 유저 생성 및 저장
        UUID accountId = generateAccount(
                ERole.fromString(role),
                serialId,
                requestDto
        );

        // Default Json Web Token 생성
        DefaultJsonWebTokenDto defaultJsonWebTokenDto = jsonWebTokenUtil.generateDefaultJsonWebTokens(
                accountId,
                ERole.USER
        );

        // Refresh Token 저장
        refreshTokenRepository.save(
                RefreshToken.builder()
                        .accountId(accountId)
                        .value(defaultJsonWebTokenDto.refreshToken())
                        .build()
        );

        // Temporary Token 삭제
        temporaryTokenRepository.deleteById(serialId);

        return defaultJsonWebTokenDto;
    }

    /**
     * Temporary Token 일치 여부 확인
     * @param serialEmail Account ID
     * @param temporaryToken Refresh Token
     * @return Redis에 저장된 Temporary Token과 일치 여부
     */
    private Boolean isEqualsTemporaryToken(String serialEmail, String temporaryToken) {
        TemporaryToken temporaryTokenEntity = temporaryTokenRepository.findById(serialEmail)
                .orElseThrow(() -> new CommonException(ErrorCode.TOKEN_INVALID_ERROR));

        return temporaryTokenEntity.getValue().equals(temporaryToken);
    }

    /**
     * 이메일 중복 검사
     * @param serialEmail 이메일
     * @return 중복 여부
     */
    private Boolean isDuplicatedEmail(String serialEmail) {
        return accountRepository.findBySerialId(serialEmail).isPresent();
    }

    /**
     * 계정 생성
     *
     * @param role 계정 권한
     * @param serialId 계정 ID
     * @param requestDto 계정 생성 요청 DTO
     * @return 계정 ID
     */
    private UUID generateAccount(
            ERole role,
            String serialId,
            SignUpByDefaultDto requestDto
    ) {
        return switch (role) {
            case USER -> userRepository.save(
                    User.builder()
                            .serialEmail(serialId)
                            .password(bCryptPasswordEncoder.encode(requestDto.password()))
                            .provider(EProvider.DEFAULT)
                            .nickname(requestDto.nickname())
                            .build()
            ).getId();
            case EXPERT -> expertRepository.save(
                    Expert.builder()
                            .serialId(serialId)
                            .password(bCryptPasswordEncoder.encode(requestDto.password()))
                            .provider(EProvider.DEFAULT)
                            .nickname(requestDto.nickname())
                            .career(requestDto.career() == null ? "" : requestDto.career())
                            .build()
            ).getId();
            default -> throw new CommonException(ErrorCode.INVALID_ARGUMENT_FORMAT);
        };
    }
}

