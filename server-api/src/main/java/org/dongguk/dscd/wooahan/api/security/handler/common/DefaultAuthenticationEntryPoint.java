package org.dongguk.dscd.wooahan.api.security.handler.common;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class DefaultAuthenticationEntryPoint
        extends AbstractAuthenticationFailureHandler implements AuthenticationEntryPoint {

    @Override
    public void commence(
            HttpServletRequest request,
            HttpServletResponse response,
            AuthenticationException authException
    ) throws IOException {
        ErrorCode errorCode = request.getAttribute("exception") == null ?
                ErrorCode.NOT_FOUND_END_POINT : (ErrorCode) request.getAttribute("exception");

        setErrorResponse(response, errorCode);
    }
}
