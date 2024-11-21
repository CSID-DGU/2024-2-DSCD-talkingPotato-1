package org.dongguk.dscd.wooahan.api.security.handler.logout;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.dongguk.dscd.wooahan.api.core.constant.Constants;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.dongguk.dscd.wooahan.api.security.handler.common.AbstractAuthenticationFailureHandler;
import org.dongguk.dscd.wooahan.api.security.util.CookieUtil;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Component
@RequiredArgsConstructor
public class DefaultLogoutSuccessHandler extends AbstractAuthenticationFailureHandler implements LogoutSuccessHandler {

    @Override
    public void onLogoutSuccess(
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication
    ) throws IOException {
        if (authentication == null) {
            setErrorResponse(
                    response,
                    refineErrorCode(request)
            );

            return;
        }

        setSuccessResponse(
                request,
                response
        );
    }

    private ErrorCode refineErrorCode(HttpServletRequest request) {
        if (request.getAttribute("exception") == null) {
            return ErrorCode.INTERNAL_SERVER_ERROR;
        }

        return (ErrorCode) request.getAttribute("exception");
    }

    private void setSuccessResponse(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(HttpStatus.OK.value());

        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("data", null);
        result.put("error", null);

        CookieUtil.deleteCookie(request, response, Constants.ACCOUNT_ID_ATTRIBUTE_NAME);
        CookieUtil.deleteCookie(request, response, Constants.ACCESS_TOKEN_ATTRIBUTE_NAME);
        CookieUtil.deleteCookie(request, response, Constants.REFRESH_TOKEN_ATTRIBUTE_NAME);


        response.getWriter().write(objectMapper.writeValueAsString(result));
    }
}
