package org.dongguk.dscd.wooahan.api.security.util;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.util.StringUtils;

import java.util.Optional;


/**
 * Header 관련 유틸리티 클래스
 */
public class HeaderUtil {

    /**
     * Header에서 토큰을 추출한다.
     *
     * @param request HttpServletRequest
     * @param header header name
     * @param prefix prefix
     * @return Optional<String>
     */
    public static Optional<String> refineHeader(HttpServletRequest request, String header, String prefix) {
        String unpreparedToken = request.getHeader(header);

        if (!StringUtils.hasText(unpreparedToken) || !unpreparedToken.startsWith(prefix)) {
            return Optional.empty();
        }

        return Optional.of(unpreparedToken.substring(prefix.length()));
    }
}
