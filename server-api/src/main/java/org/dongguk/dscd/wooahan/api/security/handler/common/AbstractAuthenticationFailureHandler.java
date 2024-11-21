package org.dongguk.dscd.wooahan.api.security.handler.common;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletResponse;
import org.dongguk.dscd.wooahan.api.core.dto.ExceptionDto;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class AbstractAuthenticationFailureHandler {

    protected static final ObjectMapper objectMapper = new ObjectMapper();

    protected void setErrorResponse(
            HttpServletResponse response,
            ErrorCode errorCode
    ) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(errorCode.getHttpStatus().value());

        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("data", null);
        result.put("error", ExceptionDto.of(errorCode));

        response.getWriter().write(objectMapper.writeValueAsString(result));
    }

    protected void setErrorResponse(
            HttpServletResponse response,
            String message,
            ErrorCode errorCode
    ) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(errorCode.getHttpStatus().value());

        Map<String, Object> result = new HashMap<>();
        result.put("success", false);
        result.put("data", null);
        result.put("error", ExceptionDto.of(errorCode, message));

        response.getWriter().write(objectMapper.writeValueAsString(result));
    }
}

