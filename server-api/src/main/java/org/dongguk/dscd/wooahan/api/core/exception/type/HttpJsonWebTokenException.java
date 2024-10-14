package org.dongguk.dscd.wooahan.api.core.exception.type;

import io.jsonwebtoken.JwtException;
import lombok.Getter;
import org.dongguk.dscd.wooahan.api.core.exception.error.ErrorCode;

@Getter
public class HttpJsonWebTokenException extends JwtException {

    private final ErrorCode errorCode;

    public HttpJsonWebTokenException(String message, ErrorCode errorCode) {
        super(message);

        this.errorCode = errorCode;
    }
}
