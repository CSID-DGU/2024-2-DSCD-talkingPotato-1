package org.dongguk.dscd.wooahan.api.security.handler.login;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.security.dto.response.DefaultJsonWebTokenDto;
import org.dongguk.dscd.wooahan.api.security.info.UserPrincipal;
import org.dongguk.dscd.wooahan.api.security.usecase.LoginByDefaultUseCase;
import org.dongguk.dscd.wooahan.api.security.util.CookieUtil;
import org.dongguk.dscd.wooahan.api.security.util.JsonWebTokenUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class DefaultLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Value("${spring.cookie-url}")
    private String cookieUrl;

    private final LoginByDefaultUseCase loginByDefaultUseCase;

    private final JsonWebTokenUtil jsonWebTokenUtil;
    private final ObjectMapper objectMapper;

    @Override
    public void onAuthenticationSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication
    ) throws IOException {
        // 1. Create Default JsonWebToken
        UserPrincipal principal = (UserPrincipal) authentication.getPrincipal();
        DefaultJsonWebTokenDto jsonWebTokenDto = jsonWebTokenUtil.generateDefaultJsonWebTokens(
                principal.getId(),
                principal.getRole()
        );

        // 2. Update User's Token
        loginByDefaultUseCase.execute(principal, jsonWebTokenDto);

        // 3. Set JsonWebToken to Response
        String userAgent = request.getHeader("User-Agent");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        response.setStatus(HttpStatus.CREATED.value());

        if (userAgent != null && userAgent.contains("Mozilla")) {
            onSuccessWebResponse(
                    principal.getId(),
                    response,
                    jsonWebTokenDto
            );
        } else {
            onSuccessAppResponse(
                    principal.getId(),
                    response,
                    jsonWebTokenDto
            );
        }
    }

    private void onSuccessWebResponse(
            UUID accountId,
            HttpServletResponse response,
            DefaultJsonWebTokenDto tokenDto
    ) {
        CookieUtil.addCookie(
                response,
                cookieUrl,
                Constants.ACCOUNT_ID_ATTRIBUTE_NAME,
                accountId.toString()
        );
        CookieUtil.addCookie(
                response,
                cookieUrl,
                Constants.ACCESS_TOKEN_ATTRIBUTE_NAME,
                tokenDto.accessToken()
        );
        CookieUtil.addSecureCookie(
                response,
                cookieUrl,
                Constants.REFRESH_TOKEN_ATTRIBUTE_NAME,
                tokenDto.refreshToken(),
                (int) (jsonWebTokenUtil.getRefreshTokenExpirePeriod() / 1000L)
        );
    }

    private void onSuccessAppResponse(
            UUID accountId,
            HttpServletResponse response,
            DefaultJsonWebTokenDto tokenDto
    ) throws IOException {
        Map<String, Object> result = new HashMap<>();

        result.put("success", true);
        result.put("data", Map.of(
                Constants.ACCOUNT_ID_ATTRIBUTE_NAME, accountId,
                Constants.ACCESS_TOKEN_ATTRIBUTE_NAME, tokenDto.accessToken(),
                Constants.REFRESH_TOKEN_ATTRIBUTE_NAME, tokenDto.refreshToken()
        ));
        result.put("error", null);

        response.getWriter().write(objectMapper.writeValueAsString(result));
    }
}
