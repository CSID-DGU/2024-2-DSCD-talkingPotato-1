package org.dongguk.dscd.wooahan.api.security.handler.common;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class DefaultAccessDeniedHandler
        extends AbstractAuthenticationFailureHandler implements AccessDeniedHandler {

    @Override
    public void handle(
            HttpServletRequest request,
            HttpServletResponse response,
            AccessDeniedException accessDeniedException
    ) throws IOException {
        setErrorResponse(response, ErrorCode.ACCESS_DENIED);
    }
}
