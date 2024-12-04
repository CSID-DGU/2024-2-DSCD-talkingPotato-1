package org.dongguk.dscd.wooahan.api.security.controller.command;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.dongguk.dscd.wooahan.api.core.annotation.common.AccountID;
import org.dongguk.dscd.wooahan.api.core.annotation.valid.EnumValue;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.dto.ResponseDto;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.core.exception.type.CommonException;
import org.dongguk.dscd.wooahan.api.security.domain.type.ERole;
import org.dongguk.dscd.wooahan.api.security.dto.request.SignUpByDefaultDto;
import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateAuthenticationCodeDto;
import org.dongguk.dscd.wooahan.api.security.dto.request.ValidateEmailDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.dto.response.TemporaryJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.usecase.*;
import org.dongguk.dscd.wooahan.api.security.util.CookieUtil;
import org.dongguk.dscd.wooahan.api.security.util.HeaderUtil;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class AuthCommandController {

    @Value("${spring.cookie-url}")
    private String cookieUrl;

    private final SignUpByDefaultUseCase signUpByDefaultUseCase;
    private final WithdrawalUseCase withdrawalUseCase;
    private final ReissueJsonWebTokenUseCase reissueJsonWebTokenUseCase;
    private final ReissuePasswordUseCase reissuePasswordUseCase;

    private final ValidateEmailUseCase validateEmailUseCase;
    private final ValidateAuthenticationCodeUseCase validateAuthenticationCodeUseCase;

    private final JsonWebTokenUtil jsonWebTokenUtil;
    private final ObjectMapper objectMapper;


    /**
     * 1-3. 회원 탈퇴
     *
     * @param accountId 계정 ID
     * @return NoContent
     */
    @PreAuthorize("hasAnyRole('USER', 'EXPERT', 'ADMIN')")
    @PostMapping("/withdrawal")
    public ResponseDto<?> withdrawal(
            @AccountID UUID accountId
    ) {
        withdrawalUseCase.execute(accountId);

        return ResponseDto.noContent();
    }

    /**
     * 1-4. 비밀번호 재발급
     *
     * @param request HttpServletRequest
     * @return NoContent
     */
    @PostMapping("/reissue/password")
    public ResponseDto<?> reissuePassword(
            HttpServletRequest request
    ) {
        String temporaryToken = HeaderUtil.refineHeader(request, Constants.AUTHORIZATION_HEADER, Constants.BEARER_PREFIX)
                .orElseThrow(() -> new CommonException(ErrorCode.INVALID_HEADER_FORMAT));

        reissuePasswordUseCase.execute(temporaryToken);

        return ResponseDto.noContent();
    }

    /**
     * 1-5. Default JsonWebToken 재발급
     *
     * @param request  HttpServletRequest
     * @param response HttpServletResponse
     * @throws IOException IOException
     */
    @PostMapping("/reissue/token")
    public void reissueDefaultJsonWebToken(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {
        String userAgent = request.getHeader("User-Agent");

        // 1. Get Refresh Token
        String refreshToken = null;

        if (userAgent != null && userAgent.contains("Mozilla")) {
            refreshToken = CookieUtil.refineCookie(request, Constants.REFRESH_TOKEN_ATTRIBUTE_NAME)
                    .orElseThrow(() -> new CommonException(ErrorCode.INVALID_HEADER_FORMAT));
        } else {
            refreshToken = HeaderUtil.refineHeader(request, Constants.AUTHORIZATION_HEADER, Constants.BEARER_PREFIX)
                    .orElseThrow(() -> new CommonException(ErrorCode.INVALID_HEADER_FORMAT));
        }

        // 2. Create Default JsonWebToken
        DefaultJsonWebTokenDto defaultJsonWebTokenDto = reissueJsonWebTokenUseCase.execute(refreshToken);

        // 3. Set JsonWebToken to Response
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.setStatus(HttpStatus.CREATED.value());

        if (userAgent != null && userAgent.contains("Mozilla")) {
            CookieUtil.addCookie(
                    response,
                    cookieUrl,
                    Constants.ACCESS_TOKEN_ATTRIBUTE_NAME,
                    defaultJsonWebTokenDto.accessToken()
            );
            CookieUtil.addSecureCookie(
                    response,
                    cookieUrl,
                    Constants.REFRESH_TOKEN_ATTRIBUTE_NAME,
                    defaultJsonWebTokenDto.refreshToken(),
                    (int) (jsonWebTokenUtil.getRefreshTokenExpirePeriod() / 1000L)
            );
        } else {
            Map<String, Object> result = new HashMap<>();

            result.put("success", true);
            result.put("data", defaultJsonWebTokenDto);
            result.put("error", null);

            response.getWriter().write(objectMapper.writeValueAsString(result));
        }
    }

    /**
     * 2-1. 이메일 검증(유효한 Email 인지 확인)
     *
     * @param requestDto ValidateEmailDto
     * @return 인증횟수를 포함한 ResponseDto
     */
    @PostMapping("/validations/email")
    public ResponseDto<?> validateEmail(
            @RequestBody @Valid ValidateEmailDto requestDto
    ) {
        return ResponseDto.created(validateEmailUseCase.execute(requestDto));
    }

    /**
     * 2-2. 인증 코드 검증
     *
     * @param request     HttpServletRequest
     * @param response    HttpServletResponse
     * @param requestDto  ValidateAuthenticationCodeDto
     * @throws IOException IOException
     */
    @PostMapping("/validations/authentication-code")
    public void validateAuthenticationCode(
            HttpServletRequest request,
            HttpServletResponse response,
            @RequestBody @Valid ValidateAuthenticationCodeDto requestDto
    ) throws IOException {
        // 1. Create Temporary JsonWebToken
        TemporaryJsonWebTokenDto temporaryJsonWebTokenDto = validateAuthenticationCodeUseCase.execute(requestDto);

        // 2. Set JsonWebToken to Response
        String userAgent = request.getHeader("User-Agent");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.setStatus(HttpStatus.CREATED.value());

        if (userAgent != null && userAgent.contains("Mozilla")) {
            CookieUtil.addCookie(
                    response,
                    cookieUrl,
                    Constants.TEMPORARY_TOKEN_ATTRIBUTE_NAME,
                    temporaryJsonWebTokenDto.temporaryToken()
            );
        } else {
            Map<String, Object> result = new HashMap<>();

            result.put("success", true);
            result.put("data", temporaryJsonWebTokenDto);
            result.put("error", null);

            response.getWriter().write(objectMapper.writeValueAsString(result));
        }
    }

    /**
     * 2-3. 회원가입
     * @param request HttpServletRequest
     * @param role    ERole
     * @param requestDto SignUpByDefaultDto
     *
     * @return Default JsonWebToken
     */
    @PostMapping("/sign-up")
    public ResponseDto<?> signUp(
            HttpServletRequest request,
            @RequestParam("role") @EnumValue(enumClass = ERole.class) String role,
            @RequestBody @Valid SignUpByDefaultDto requestDto
    ) {
        if (role.equals(ERole.ADMIN.getEnName())) {
            throw new CommonException(ErrorCode.ACCESS_DENIED);
        }

        String temporaryToken = HeaderUtil.refineHeader(request, Constants.AUTHORIZATION_HEADER, Constants.BEARER_PREFIX)
                .orElseThrow(() -> new CommonException(ErrorCode.INVALID_HEADER_FORMAT));

        return ResponseDto.created(
                signUpByDefaultUseCase.execute(
                        role,
                        temporaryToken,
                        requestDto
                )
        );
    }
}
